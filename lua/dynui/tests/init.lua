local mats = {
    ["SCP682"] = Material("fv_addons/682_leftmouse.png")
}

local function openmenu()
    local frame = vgui.Create("DynFrame")

    frame:SetSize( ScrW() * .9, ScrH() * .9 )
    frame:Center()
    frame:MakePopup()
    frame:DoHeader()
    frame:SetTitle("Dynamic Jobs")

    local sidebar = frame:Add("DynSidebar")
    sidebar:AddTab("Test", mats.SCP682, true)
    sidebar:AddTab("A Second Test", mats.SCP682)

    local btn = sidebar.Tabs["Test"]:Add("DynButton")
    btn:SetSize(200, 30)
    btn:CenterHorizontal()
    btn:SetY(100)
    btn:SetTextColor(color_black)
    btn:SetColor(DynUI.Close)
    btn:SetDText("Cool Button :)")

    local btn2 = sidebar.Tabs["Test"]:Add("DynButton")
    local success = Color(26,230,60)
    btn2:SetSize(200, 30)
    btn2:CenterHorizontal()
    btn2:SetY(150)
    btn2:SetColor(success)
    btn2:SetTextColor(color_black)
    btn2:SetDText("Cooler Button :)")

    local btn3 = sidebar.Tabs["Test"]:Add("DynButton")
    local primary = Color(26,121,230)
    btn3:SetSize(200, 30)
    btn3:CenterHorizontal()
    btn3:SetY(200)
    btn3:SetColor(primary)
    btn3:SetTextColor(color_black)
    btn3:SetDText("Coolest Button :)")
    DynUI:MakeTooltip(sidebar.Tabs["Test"], btn3, "OH MY GOD IS THAT AMONG US", 220)

    local btn4 = sidebar.Tabs["A Second Test"]:Add("DynButton")
    btn4:SetSize(400, 40)
    btn4:Center()
    btn4:SetColor(primary)
    btn4:SetTextColor(color_black)
    btn4:SetDText("THE SECRET UBER COOL BUTTON")

    local switch = sidebar.Tabs["Test"]:Add("DynSwitch")
    switch:Center()
    DynUI:MakeTooltip(sidebar.Tabs["Test"], switch, "Sussy Baka")
end

concommand.Add("dynui", openmenu)