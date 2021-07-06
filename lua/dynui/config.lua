DynUI = {
    ["Primary"] = Color(48,50,54),
    ["Header"] = Color(33,36,41),
    ["Neutral"] = Color(114,114,114),
    ["Title"] = color_white,
    ["Close"] = Color(197,64,64),
    ["Minimize"] = Color(224,174,38),
    ["Sidebar"] = {
        ["Primary"] = Color(56,59,61),
        ["Indicator"] = Color(37,146,219)
    },
    ["Switch"] = { 
        ["Enabled"] = Color(25,202,49),
        ["Disabled"] = Color(233,84,84)
    },
    ["Tooltip"] = Color(0,0,0,234),
    ["Sounds"] = {
        ["Switch"] = Sound("dynui/toggle_click.wav")
    },
    ["Buttons"] = {
        ["Primary"] = Color(26,121,230),
        ["Success"] = Color(26,230,60)
    }
}

if CLIENT then
    function DynUI:AddFont(name,size,weight)
        surface.CreateFont("DynUI_"..name, {
            font = "Montserrat",
            size = size or 25,
            weight = weight or 500,
            antialias = true
        })
    end

    function DynUI:DrawCircle( x, y, radius, seg )
        local cir = {}

        table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
        for i = 0, seg do
            local a = math.rad( ( i / seg ) * -360 )
            table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
        end

        local a = math.rad( 0 )
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

        surface.DrawPoly( cir )
    end

    function DynUI:DarkenColor(color)
        local hovCol = Color(color.r - 30 , color.g - 30 , color.b - 30)
        return hovCol
    end

    function DynUI:LightenColor(color)
        local hovCol = Color(color.r + 8 , color.g + 8 , color.b + 8)
        return hovCol
    end

    function DynUI:MakeTooltip(mainparent, parent, message, width)
        local tt = vgui.Create("DynTooltip")
        tt:SetTTParent(parent)
        tt:SetParent(mainparent)
        tt:SetTTText(message)
        tt:SetMouseInputEnabled(false)
        if width and width > 100 then
            tt:SetWide(width) 
        end
    end

    function DynUI:ConfirmAction(ttl, text, callback, closecallback)
        local frame = vgui.Create("DynFrame")
        frame:SetBlur( true )
        frame:SetDrawOnTop( true )

        local title = frame:Add("DLabel")
        title:SetText(ttl or "Are You Sure?")
        title:SetFont("DynUI_Query_Title")
        title:SizeToContents()
        title:SetContentAlignment(5)
        title:SetY(10)
        title:SetColor(color_white)

        local message = frame:Add("DLabel")
        message:SetText(text or "Please confirm this action.")
        message:SetFont("DynUI_Sidebar")
        message:SizeToContents()
        message:SetContentAlignment(5)
        message:SetY(70)

        local btns_cont = frame:Add("DPanel")
        btns_cont:SetY(100)
        btns_cont:Dock(BOTTOM)
        btns_cont:SetTall(30)
        btns_cont:SetPaintBackground(false)
        btns_cont:DockMargin(0,0,0,5)

        local confirm = btns_cont:Add("DynButton")
        confirm:SetDText("Confirm Action")
        confirm:SetColor(DynUI.Close)
        confirm:Dock(LEFT)
        function confirm:DoClick()
            frame:Remove()
            if callback then callback() end
        end

        local close = btns_cont:Add("DynButton")
        close:SetDText("Cancel")
        close:SetColor(DynUI.Neutral)
        close:Dock(RIGHT)
        function close:DoClick()
            frame:Remove()
            if closecallback then closecallback() end
        end


        -- Frame sizing
        local w, h = message:GetWide() + 50, title:GetTall() + message:GetTall() + btns_cont:GetTall() + 80
        if title:GetWide() > message:GetWide() then w = title:GetWide() + 50 end
        if w < 500 then w = 500 end
        

        frame:SetSize(w,h)
        frame:SetContentAlignment(5)
        frame:MakePopup()
        frame:Center()
        frame:DoModal()

        -- Buttons sizing
        btns_cont:DockPadding(frame:GetWide() * .05, 0, frame:GetWide() * .05, 0)
        confirm:SetSize(frame:GetWide() * .4, 30)
        close:SetSize(frame:GetWide() * .4, 30)

        -- Text centering
        title:CenterHorizontal()
        message:CenterHorizontal()

        return frame
    end
end