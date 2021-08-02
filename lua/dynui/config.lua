DynUI = {
    ["Primary"] = Color(48,50,54),
    ["Header"] = Color(33,36,41),
    ["Neutral"] = Color(114,114,114),
    ["Grey"] = Color(235,235,235),
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
        ["Success"] = Color(30,163,52)
    }
}

AddCSLuaFile("dynui/lib/circles.lua")
if CLIENT then
    function DynUI:AddFont(name,size,weight)
        surface.CreateFont("DynUI_"..name, {
            font = "Rubik",
            size = size or 25,
            weight = weight or 500,
            antialias = true
        })
    end

    DynUI.Circles = include("dynui/lib/circles.lua")

    function DynUI:DarkenColor(color, amount)
        local change = amount or 30
        local hovCol = Color(color.r - change , color.g - change , color.b - change)
        return hovCol
    end

    function DynUI:LightenColor(color, amount)
        local change = amount or 10
        local hovCol = Color(color.r + change , color.g + change , color.b + change)
        return hovCol
    end

    function DynUI:LerpColor(from, to)
        return Color(
            math.Approach(from.r, to.r, 12),
            math.Approach(from.g, to.g, 12),
            math.Approach(from.b, to.b, 12),
            math.Approach(from.a or 255, to.a or 255, 12)
        )
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
        frame = vgui.Create("DynFrame")
        frame:SetBlur( true )
        frame:SetDrawOnTop( true )

        frame.title = frame:Add("DLabel")
        frame.title:SetText(ttl or "Are You Sure?")
        frame.title:SetFont("DynUI_Query_Title")
        frame.title:SizeToContents()
        frame.title:SetContentAlignment(5)
        frame.title:SetY(10)
        frame.title:SetColor(color_white)

        frame.message = frame:Add("DLabel")
        frame.message:SetText(text or "Please confirm this action.")
        frame.message:SetFont("DynUI_Sidebar")
        frame.message:SizeToContents()
        frame.message:SetContentAlignment(5)
        frame.message:SetY(70)

        frame.btns_cont = frame:Add("DPanel")
        frame.btns_cont:SetY(100)
        frame.btns_cont:Dock(BOTTOM)
        frame.btns_cont:SetTall(30)
        frame.btns_cont:SetPaintBackground(false)
        frame.btns_cont:DockMargin(0,0,0,5)

        frame.confirm = frame.btns_cont:Add("DynButton")
        frame.confirm:SetDText("Confirm Action")
        frame.confirm:SetColor(DynUI.Close)
        frame.confirm:Dock(LEFT)
        function frame.confirm:DoClick()
            frame:Remove()
            if callback then callback() end
        end

        frame.close = frame.btns_cont:Add("DynButton")
        frame.close:SetDText("Cancel")
        frame.close:SetColor(DynUI.Neutral)
        frame.close:Dock(RIGHT)
        function frame.close:DoClick()
            frame:Remove()
            if closecallback then closecallback() end
        end


        -- Frame sizing
        local w, h = frame.message:GetWide() + 50, frame.title:GetTall() + frame.message:GetTall() + frame.btns_cont:GetTall() + 80
        if frame.title:GetWide() > frame.message:GetWide() then w = frame.title:GetWide() + 50 end
        if w < 500 then w = 500 end
        

        frame:SetSize(w,h)
        frame:SetContentAlignment(5)
        frame:MakePopup()
        frame:Center()
        frame:DoModal()

        -- Buttons sizing
        frame.btns_cont:DockPadding(frame:GetWide() * .05, 0, frame:GetWide() * .05, 0)
        frame.confirm:SetSize(frame:GetWide() * .4, 30)
        frame.close:SetSize(frame:GetWide() * .4, 30)

        -- Text centering
        frame.title:CenterHorizontal()
        frame.message:CenterHorizontal()

        return frame
    end
end