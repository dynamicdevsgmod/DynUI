local PANEL = {}

function PANEL:Init()
    self.Font = "DynUI_Title"
    self.NoFocusColor = DynUI:DarkenColor(color_white, 70)
    self.TextColor = color_white
    self.HighlightColor = Color(18,110,196)
    self.AccentColor = Color(255,255,255)
    self:SetCursor("beam")

    self.Disabled = false
    
    self.Decoration = self:Add("DPanel")
    self.Decoration:Dock(BOTTOM)
    self.Decoration:SetTall(2)
    self.Decoration:SetBackgroundColor(self.AccentColor)
    self.Decoration.SetColor = self.Decoration.SetBackgroundColor
    self.Decoration.GetColor = self.Decoration.GetBackgroundColor

    self.TextEntry = self:Add("DTextEntry")
    self.TextEntry:Dock(FILL)
    self.TextEntry:DockMargin(0,2,2,2)
    self.TextEntry:SetDrawLanguageID(false)
    self.TextEntry:SetFont(self.Font)
    self.TextEntry.Paint = function(me,w,h)
        me:DrawTextEntryText(self.TextColor, self.HighlightColor, color_white)
    end
    self.TextEntry.OnFocusChanged = function(_me, focus)
        if focus then 
            self.Decoration:ColorTo(DynUI:DarkenColor(self.AccentColor), .25, 0)
        else
            self.Decoration:ColorTo(self.AccentColor, .25, 0)
        end
    end
end

function PANEL:SetText(text) self.TextEntry:SetText(text) end
function PANEL:GetText() return self.TextEntry:GetText() end

function PANEL:SetFont(font) self.Font = font self.TextEntry:SetFont(font) end
function PANEL:GetFont() return self.Font end

function PANEL:SetTextColor(color) self.TextColor = color self.TextEntry:SetTextColor(color) end
function PANEL:GetTextColor() return self.TextColor end

function PANEL:SetAccentColor(color) self.AccentColor = color self.Decoration:SetBackgroundColor(self.AccentColor) end
function PANEL:GetAccentColor() return self.AccentColor end

function PANEL:SetDisabled(disable)
    self:SetKeyboardInputEnabled(!disable)
    self.TextEntry:SetMouseInputEnabled(!disable)

    if disable then
        self:SetCursor("no")
        self.TextEntry:SetCursor("no")
    else
        self:SetCursor("beam")
        self.TextEntry:SetCursor("beam")
    end
end

function PANEL:GetDisabled() return self.Disabled end

derma.DefineControl("DynTextEntry", "Dynamic VGUI Text Field", PANEL, "Panel")