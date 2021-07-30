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
    sidebar:AddTab("Settings", mats.Home, true)

    do -- Settings Tab
        local panel = sidebar.Tabs["Settings"]
        
        local scroll = panel:Add("DScrollPanel")
        scroll:SetWide( panel:GetWide() * .5 )
        scroll:SetTall( panel:GetTall() - 20 )
        scroll:SetBackgroundColor(color_white)
        scroll:CenterHorizontal()
        local bar = scroll:GetVBar()
        bar:SetWide(8)
        bar:SetHideButtons(true)
        bar.Paint = nil

        do
            local col = DynUI.Neutral
            local col2 = DynUI:LightenColor(DynUI.Neutral, 20)

            bar.btnGrip.Paint = function(me,w,h)

                if me:IsHovered() or me.Depressed then
                    col = col2
                else
                    col = DynUI.Neutral
                end
                
                draw.RoundedBox(12,0,0,w,h,col)
            end
        end


        do -- Delete Data
            local delete_data = scroll:Add("DPanel")
            delete_data:Dock(TOP)
            delete_data:DockMargin(0,30,10,0)
            function delete_data:Paint() end
    
            delete_data.label = delete_data:Add("DLabel")
            delete_data.label:SetText("Delete all save data:")
            delete_data.label:SetFont("DynUI_Title")
            delete_data.label:Dock(LEFT)
            delete_data.label:SizeToContentsX()
    
            delete_data.button = delete_data:Add("DynButton")
            delete_data.button:Dock(RIGHT)
            delete_data.button:SetSize( scroll:GetWide() * .4, 30 )
            delete_data.button:SetColor(DynUI.Close)
            delete_data.button:SetDText("Delete All Data")
            function delete_data.button:DoClick()
                DynUI:ConfirmAction(nil, "Delete all Dynamic data?", function() frame:Remove() end, function()
                    self:EndSpinner()
                    self:SetDText("Action Cancelled")
                    
                    timer.Simple(1.5, function() 
                        if not IsValid(self) then return end 
                        self:SetDText("Delete All Data")
                    end)
                end )
            end

            delete_data:SetTall(30)
        end

        do -- Random Button
            local random_button = scroll:Add("DPanel")
            random_button:Dock(TOP)
            random_button:DockMargin(0,20,10,0)
            function random_button:Paint() end
            
            random_button.label = random_button:Add("DLabel")
            random_button.label:SetText("Click this:")
            random_button.label:SetFont("DynUI_Title")
            random_button.label:Dock(LEFT)
            random_button.label:SizeToContentsX()

            random_button.button = random_button:Add("DynButton")
            random_button.button:Dock(RIGHT)
            random_button.button:SetSize( scroll:GetWide() * .4, 30 )
            random_button.button:SetColor(DynUI.Buttons.Primary)
            random_button.button:SetDText("Click Me")
            function random_button.button:DoClick()
                self:DoSpinner()
                
                timer.Simple(1, function()
                    if not IsValid(self) then return end

                    self:EndSpinner()
                end )
            end

            random_button:SetTall(30)
        end

        do -- Toggle theme
            local toggle_theme = scroll:Add("DPanel")
            toggle_theme:Dock(TOP)
            toggle_theme:DockMargin(0,20,10,0)
            function toggle_theme:Paint() end

            toggle_theme.label = toggle_theme:Add("DLabel")
            toggle_theme.label:SetText("Toggle menu theme:")
            toggle_theme.label:SetFont("DynUI_Title")
            toggle_theme.label:Dock(LEFT)
            toggle_theme.label:SizeToContentsX()

            toggle_theme.switch = toggle_theme:Add("DynSwitch")
            toggle_theme.switch:SetX(scroll:GetWide() * .75)
            toggle_theme.switch:SetWide(60)
            DynUI:MakeTooltip(parent, toggle_theme.switch, "Toggles between two values", 190)
            
            toggle_theme:SetTall(30)
        end

        do -- Color Picker
            local color_picker = scroll:Add("DPanel")
            color_picker:Dock(TOP)
            color_picker:DockMargin(0,20,10,0)
            function color_picker:Paint() end

            color_picker.label = color_picker:Add("DLabel")
            color_picker.label:SetText("Pick a color:")
            color_picker.label:SetFont("DynUI_Title")
            color_picker.label:Dock(LEFT)
            color_picker.label:SizeToContentsX()

            color_picker.picker = color_picker:Add("DColorMixer")
            color_picker.picker:Dock(RIGHT)

            color_picker:SetTall(color_picker.picker:GetTall())
        end

        do -- Color Picker
            local color_picker = scroll:Add("DPanel")
            color_picker:Dock(TOP)
            color_picker:DockMargin(0,20,10,0)
            function color_picker:Paint() end

            color_picker.label = color_picker:Add("DLabel")
            color_picker.label:SetText("Pick another color:")
            color_picker.label:SetFont("DynUI_Title")
            color_picker.label:Dock(LEFT)
            color_picker.label:SizeToContentsX()

            color_picker.picker = color_picker:Add("DColorMixer")
            color_picker.picker:Dock(RIGHT)

            color_picker:SetTall(color_picker.picker:GetTall())
        end

        do -- Color Picker
            local color_picker = scroll:Add("DPanel")
            color_picker:Dock(TOP)
            color_picker:DockMargin(0,20,10,0)
            function color_picker:Paint() end

            color_picker.label = color_picker:Add("DLabel")
            color_picker.label:SetText("And another:")
            color_picker.label:SetFont("DynUI_Title")
            color_picker.label:Dock(LEFT)
            color_picker.label:SizeToContentsX()

            color_picker.picker = color_picker:Add("DColorMixer")
            color_picker.picker:Dock(RIGHT)

            color_picker:SetTall(color_picker.picker:GetTall())
        end

        do -- Save
            local save = scroll:Add("DynButton")
            save:Dock(TOP)
            save:DockMargin(0,20,10,20)
            save:SetTall(30)
            save:SetColor(DynUI.Buttons.Success)
            save:SetDText("Save")
            function save:DoClick()
                local confirm = DynUI:ConfirmAction("That didn't do anything.", "Nothing saved, get fucked.", nil, nil)
                confirm.confirm:SetDText("Okay")
                confirm.close:SetDText("Okay :(")
                frame:Remove()
            end
        end
    end

end

concommand.Add("dynui", openmenu)