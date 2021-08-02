local PANEL = {}

function PANEL:Init()
    self.Font = "DynUI_Title"
    self.NoFocusColor = DynUI:DarkenColor(color_white, 70)
    self.TextColor = color_white

    self.Color = self.TextColor
    self.HighlightColor = Color(18,110,196)

    self:SetCursor("beam")
    
    local text = self:Add("DTextEntry")
    text:Dock(FILL)
    text:DockMargin(0,0,0,2)
    text:SetDrawLanguageID(false)
    text:SetFont(self.Font)
    text.Paint = function(me,w,h)
        me:DrawTextEntryText(self:GetTextColor(), self.HighlightColor, color_white)
    end
end

function PANEL:Paint(w,h)
    surface.SetDrawColor(Color(177,51,51))
    surface.DrawRect(0, h - 2, w, 2)
end

function PANEL:SetText(text) self.Text = text end
function PANEL:GetText() return self.Text end

function PANEL:SetFont(font) self.Font = font end
function PANEL:GetFont() return self.Font end

function PANEL:SetTextColor(color) self.TextColor = color end
function PANEL:GetTextColor() return self.TextColor end

derma.DefineControl("DynTextEntry", "Dynamic VGUI Text Field", PANEL, "Panel")