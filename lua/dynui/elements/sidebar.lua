local PANEL = {}
PANEL.Tabs = {}

function PANEL:Init()
    local parent = self:GetParent()

    if not parent.Header then
        self:SetSize( 200 , parent:GetTall())
        self:SetPos( (self:GetWide() - 50) * -1 ,0)
    else
        self:SetSize( 200 , parent:GetTall() - 30)
        self:SetPos( (self:GetWide() - 50) * -1 , 30)
    end

    self:MoveToBack()

    self.indicator = self:Add("DPanel")
    self.indicator:SetPos(self:GetWide() - 2, 0)
    self.indicator:SetSize(5, 50)
    self.indicator.Paint = function(me,w,h)
        surface.SetDrawColor(DynUI.Sidebar.Indicator)
        surface.DrawRect(0,0,w,h)
    end

    self.Tabs = {}
    self.ActiveTab = nil
    self.TabButtons = {}
end

function PANEL:Paint(w,h)
    if self:IsHovered() or self:IsChildHovered() then
        if self.Open then 
            self:MoveTo( 0, self:GetY(), .3, 0, .5 )
            self.Open = false
        end
    else
        if not self.Open then 
            self:MoveTo( (self:GetWide() - 50) * -1, self:GetY(), .3, 0, .5 )
            self.Open = true
        end

    end
    draw.RoundedBoxEx( 4, 0, 0, w, h, DynUI.Sidebar.Primary, true, false, true, false )
end

function PANEL:AddNavPanel(name)
    local frame = self:GetParent()

    self.Tabs[name] = frame:Add("DPanel")

    if not frame.Header then
        self.Tabs[name]:SetPos(50, 0)
        self.Tabs[name]:SetSize( frame:GetWide() - 50, frame:GetTall() )
    else
        self.Tabs[name]:SetSize( frame:GetWide() - 50, frame:GetTall() - 30 )
        self.Tabs[name]:SetPos(50,30)
    end
    self.Tabs[name]:SetBackgroundColor(DynUI.Primary)

    self.Tabs[name]:MoveToBack()
    self.Tabs[name]:Hide()

    return self.Tabs[name]
end

function PANEL:AddTab(str_name, mat_icon, first)
    local tab = self:AddNavPanel(str_name)

    self.TabButtons[str_name] = self:Add("DButton")
    self.TabButtons[str_name]:Dock(TOP)
    self.TabButtons[str_name]:SetTall(50)
    self.TabButtons[str_name]:SetText("")
    self.TabButtons[str_name].Paint = function(me,w,h)
        local width,height = draw.SimpleText(str_name, "DynUI_Sidebar", 5, h *.32, color_white, TEXT_ALIGN_LEFT)
    
        if width > self:GetWide() - 55 then
            self:SetWide(width + 60)
            self:SetX((self:GetWide() - 50) * -1)
            self.indicator:SetX(self:GetWide() - 2)
        end
    end

    self.TabButtons[str_name].DoClick = function(me)
        self.Tabs[self.ActiveTab]:Hide()
        self.Tabs[str_name]:Show()
        self.ActiveTab = str_name
        self.indicator:MoveTo(self.indicator:GetX(), me:GetY(), .3, 0, .5)
    end

    local IconContainer = self.TabButtons[str_name]:Add("DPanel")
    IconContainer:Dock(RIGHT)
    IconContainer:SetWide(50)
    IconContainer:SetTall(50)
    IconContainer:DockPadding(10,10,10,10)
    IconContainer:SetBackgroundColor(color_transparent)
    IconContainer:SetMouseInputEnabled(false)

    local icon = IconContainer:Add("DImage")
    icon:Dock(FILL)
    icon:SetMaterial(mat_icon)

    if first then
        self.Tabs[str_name]:Show()
        self.ActiveTab = str_name
    end

    return self.Tabs[str_name]
end

derma.DefineControl("DynSidebar", "Dynamic VGUI Sidebar", PANEL, "DPanel")