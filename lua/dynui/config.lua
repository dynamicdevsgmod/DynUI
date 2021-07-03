DynUI = {
    ["Primary"] = Color(48,50,54),
    ["Header"] = Color(33,36,41),
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
end