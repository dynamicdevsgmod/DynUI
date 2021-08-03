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
        self.Header.MouseX,self.Header.MouseY = self.Header:CursorPos()
    end
    self.Header.OnMouseReleased = function(me,kc)
        self.Dragging = nil
        self:MouseCapture(false)
        self.Header.MouseX,self.Header.MouseY = nil
    end
    self.Header.Think = function(me)
        if not self.Dragging then return end
        if not input.IsMouseDown(MOUSE_LEFT) then self:MouseCapture(false) self.Dragging = nil return end
    
        local x,y = gui.MouseX(), gui.MouseY() - self.Header.MouseY
        self:SetPos(x - self.Header.MouseX,y)

        if self:GetY() < 0 then self:SetY(0) end
    end

    self.ResetHeight = self:GetTall()
    self.MinHeight = self.Header:GetTall()
    
    local cir = DynUI.Circles.New(CIRCLE_FILLED, 8, 30 * .5, self.Header:GetTall() * .5)
    cir:SetDistance(1)

    local close = self.Header:Add("DButton")
    close:Dock(RIGHT)
    close:SetWide(30)
    close:SetText("")
    local HovClose = DynUI:DarkenColor(DynUI.Close)
    close.Paint = function(me,w,h)
        if not me:IsHovered() then
            surface.SetDrawColor(DynUI.Close)
        else
            surface.SetDrawColor(HovClose)
        end
        draw.NoTexture()
        cir()
    end
    close.DoClick = function(me)
        self:Remove()
    end

    local minimize = self.Header:Add("DButton")
    minimize:Dock(RIGHT)
    minimize:SetWide(30)
    minimize:SetText("")
    local HovMin = DynUI:DarkenColor(DynUI.Minimize)
    minimize.Paint = function(me,w,h)
        if not me:IsHovered() then
            surface.SetDrawColor(DynUI.Minimize)
        else
            surface.SetDrawColor(HovMin)
        end
        draw.NoTexture()
        cir()
    end
    minimize.DoClick = function(me)
        if not self.Minimized then
            self:Minimize(true) 
        else
            self:Minimize(false)
        end
    end

end

function PANEL:Minimize(b_Minimize)
    if b_Minimize then
        self:SetTall(self.MinHeight)
        self:KillFocus()
        self:SetMouseInputEnabled(false)
        self:SetKeyboardInputEnabled(false)
        self:SetAlpha(180)

        gui.HideGameUI()

        timer.Simple(0, function()
            self.minOL = vgui.Create("DPanel")
            self.minOL:SetSize( self:GetWide(), self.MinHeight )
            self.minOL:SetPos( self:GetPos() )
            self.minOL:SetCursor("hand")
            self.minOL:SetMouseInputEnabled(true)
            self.minOL.Paint = function(me)
                if not IsValid(self) then me:Remove() end

                if gui.IsGameUIVisible() then
                    self:Minimize(false)
                    me:Remove()
                end
            end
            self.minOL.OnMouseReleased = function(me)
               if self.Minimized then
                    self:Minimize(false)
                    me:Remove()
                end
            end
        end )

        self.Minimized = true
    else
        self:SetTall(self.ResetHeight)
        self:SetMouseInputEnabled(true)
        self:SetKeyboardInputEnabled(true)
        self:SetAlpha(255)

        self.Minimized = false
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