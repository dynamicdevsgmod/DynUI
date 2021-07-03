local mats = {
    ["SCP682"] = Material("fv_addons/682_leftmouse.png")
}

local function openmenu()
    local frame = vgui.Create("DynFrame")

    frame:SetSize( ScrW() * .9, ScrH() * .9 )
    frame:Center()
    frame:MakePopup()
    frame:DoHeader()

    local sidebar = frame:Add("DynSidebar")
    sidebar:AddTab("Farming", mats.SCP682, true)
    sidebar:AddTab("Artist", mats.SCP682)

    local btn = sidebar.Tabs["Farming"]:Add("DynButton")
    btn:SetSize(250, 30)
    btn:CenterHorizontal()
    btn:SetY(100)
    btn:SetTextColor(color_black)
    btn:SetColor(DynUI.Close)
    btn:SetDText("Delete Something Important")
    function btn:DoClick()
        DynUI:ConfirmAction("You are not going to be able to recover the item you deleted! Seriously, you won't!")
    end

    local btn2 = sidebar.Tabs["Farming"]:Add("DynButton")
    local success = Color(26,230,60)
    btn2:SetSize(200, 30)
    btn2:CenterHorizontal()
    btn2:SetY(150)
    btn2:SetColor(success)
    btn2:SetTextColor(color_black)
    btn2:SetDText("Cooler Button :)")

    local btn3 = sidebar.Tabs["Farming"]:Add("DynButton")
    local primary = Color(26,121,230)
    btn3:SetSize(200, 30)
    btn3:CenterHorizontal()
    btn3:SetY(200)
    btn3:SetColor(primary)
    btn3:SetTextColor(color_black)
    btn3:SetDText("Coolest Button :)")
    DynUI:MakeTooltip(sidebar.Tabs["Farming"], btn3, "OH MY GOD IS THAT AMONG US",220)

    local btn4 = sidebar.Tabs["Artist"]:Add("DynButton")
    btn4:SetSize(400, 40)
    btn4:Center()
    btn4:SetColor(primary)
    btn4:SetTextColor(color_black)
    btn4:SetDText("THE SECRET UBER COOL BUTTON")

    local switch = sidebar.Tabs["Farming"]:Add("DynSwitch")
    switch:Center()
    DynUI:MakeTooltip(sidebar.Tabs["Farming"], switch, "Sussy Baka")
end

concommand.Add("dynui", openmenu)