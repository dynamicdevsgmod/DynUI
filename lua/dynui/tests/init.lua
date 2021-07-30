local mats = {
    ["Home"] = Material("dynui/cog_placeholder.png"),
    ["SCP682"] = Material("dynui/house_placeholder.png")
}

local function openmenu()
    local frame = vgui.Create("DynFrame")

    frame:SetSize( ScrW() * .9, ScrH() * .9 )
    frame:Center()
    frame:MakePopup()
    frame:DoHeader()

    local sidebar = frame:Add("DynSidebar")
    sidebar:AddTab("Tab One", mats.SCP682, true)
    sidebar:AddTab("Tab Two", mats.SCP682)

    local btn = sidebar.Tabs["Tab One"]:Add("DynButton")
    btn:SetSize(250, 30)
    btn:CenterHorizontal()
    btn:SetY(100)
    btn:SetTextColor(color_black)
    btn:SetColor(DynUI.Close)
    btn:SetDText("Delete Something Important")
    function btn:DoClick()
        DynUI:ConfirmAction(nil, "This action is irreversible.")
    end

    local btn4 = sidebar.Tabs["Tab Two"]:Add("DynButton")
    btn4:SetSize(400, 40)
    btn4:Center()
    btn4:SetColor(DynUI.Buttons.Primary)
    btn4:SetTextColor(color_black)
    btn4:SetDText("You Found The Second Tab!")
    function btn4:DoClick()
        frame:SetAlpha(180)
    end

    local switch = sidebar.Tabs["Tab One"]:Add("DynSwitch")
    switch:Center()
    switch:SetWide(60)
    switch:DoToggle(true)
    local switch_tooltip = DynUI:MakeTooltip(sidebar.Tabs["Tab One"], switch, "I'm A Very Very Very Very Long Tooltip That I Am Using To Test Scaling", 420)
end

concommand.Add("dynui", openmenu)