local mats = {
    ["SCP682"] = Material("fv_addons/682_leftmouse.png"),
    ["mask"] = Material("fv_addons/682_key.png"),
    ["rmb"] = Material("fv_addons/682_rightmouse.png")
}

local function openmenu()


    local frame = vgui.Create("DynFrame")

    frame:SetSize( ScrW() * .9, ScrH() * .9 )
    frame:Center()
    frame:MakePopup()
    frame:DoHeader()
    frame:SetTitle("Dynamic Jobs")

    local sidebar = frame:Add("DynSidebar")
    sidebar:AddTab("Home", mats.SCP682, true)
    sidebar:AddTab("SCP-682", mats.mask)
    sidebar:AddTab("Right Click", mats.rmb)

    local btn = sidebar.Tabs["Home"]:Add("DButton")
    btn:SetText("Click Me For Gay")
    btn:Center()
    btn:SizeToContents()

    local btn2 = sidebar.Tabs["SCP-682"]:Add("DButton")
    btn2:SetText("Click Me For Money")
    btn2:Center()
    btn2:SizeToContents()

    local btn3 = sidebar.Tabs["Right Click"]:Add("DButton")
    btn3:SetText("Click Me For Death")
    btn3:Center()
    btn3:SizeToContents() 
end

concommand.Add("dynui", openmenu)