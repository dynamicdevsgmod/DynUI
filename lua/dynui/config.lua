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
        ["Success"] = Color(26,230,60)
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

    function DynUI:LerpColor(fr, from, to)
        return Color(
            Lerp(fr, from.r, to.r),
            Lerp(fr, from.g, to.g),
            Lerp(fr, from.b, to.b),
            Lerp(fr, from.a or 255, to.a or 255)
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