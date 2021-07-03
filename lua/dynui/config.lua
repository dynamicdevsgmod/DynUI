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
        local hovCol = Color(0,0,0)
        hovCol.r = color.r - 30
        hovCol.g = color.g - 30
        hovCol.b = color.b - 30
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

    function DynUI:ConfirmAction(text, callback)
        local frame = vgui.Create("DynFrame")
        frame:SetBlur(true)
        frame:SetSize(ScrW() * .35,  ScrH() * .3)
        frame:Center()
        frame:MakePopup()
        frame:DoModal()

        local title = frame:Add("DLabel")
        title:SetText("Are You Sure?")
        title:SetFont("DynUI_Title")
        title:SizeToContents()
        title:CenterHorizontal()
        title:SetY(20)

        local message = frame:Add("DLabel")
        message:SetText("Lorem, ipsum dolor sit amet consectetur adipisicing elit. Vitae sapiente consequatur labore repellat saepe accusamus molestiae. Excepturi officiis sit quibusdam, laboriosam perspiciatis ipsa similique voluptates vel quaerat dolores tenetur sapiente, mollitia obcaecati laudantium et! At mollitia expedita veniam asperiores veritatis architecto omnis doloribus delectus sit consectetur? Minima sint perferendis suscipit?")
        message:SetFont("DynUI_Sidebar")
        message:SetWide(frame:GetWide() * .8)
        message:CenterHorizontal()
        -- message:

        local buttons_container = frame:Add("DPanel")
        buttons_container:SetBackgroundColor(color_transparent)
        buttons_container:SetSize(frame:GetWide() * .8, 30)
        buttons_container:SetY(frame:GetTall() - (buttons_container:GetTall() + 4))
        buttons_container:CenterHorizontal()

        local confirm = buttons_container:Add("DynButton")
        confirm:Dock(LEFT)
        confirm:SetSize(200, 30)
        confirm:SetTextColor(color_black)
        confirm:SetColor(DynUI.Close)
        confirm:SetDText("Confirm Action")
        function confirm:DoClick()
            if callback then
                callback()
            end
            frame:Remove()
        end

        local cancel = buttons_container:Add("DynButton")
        cancel:Dock(RIGHT)
        cancel:SetSize(200, 30)
        cancel:SetTextColor(color_black)
        cancel:SetColor(DynUI.Neutral)
        cancel:SetDText("Cancel")
        function cancel:DoClick()
            frame:Remove()
        end
    end
end