# DynUI
This library includes components very similar to the default VGUI components (like "DFrame" and "DButton"), but they actually look good (thank god). 
They also have some unique cases that you'll have to pay attention to when using this library.

# Components
## DynFrame
### Methods
#### void DoHeader()
Whether or not to draw the header.

## DynSidebar
### Details
Can only use on frames and panels (only recommended to use on the main frame, but if you want to try it on some child panel then don't cry about it if something breaks).

Animates out when hovered, has an indicator of the active tab that moves to wherever the button for the aforementioned tab is.

After creating a tab, you can add stuff to the actual panel of the tab by indexing the "Tabs" table of the sidebar element. Example:
```lua
local sidebar = vgui.Create("DynSidebar", frame)
sidebar:AddTab("The First Tab", SomeMaterial, true)

local btn = sidebar.Tabs["The First Tab"]:Add("DButton")
btn:SetText("Click Me")
btn:Center()
```
### Methods
#### void AddTab(name, material, first)
Name: Name of the tab to reference by as well as what shows up in the menu.
Material: Material for the icon using the Material() function. Can not be nil.
First: Whether or not this is the tab you want to be already active when the menu first opens. **DO NOT SET THIS TO TRUE ON MULTIPLE TABS**

## DynButton
### Details
There is currently a bug where you can't make the buttons too tall or else they will look weird [github issue with image](https://github.com/dynamicdevsgmod/DynUI/issues/1). Sorry but I don't have a fix right now, and frankly the buttons should never be that big anyways.

### Methods
#### Color SetColor(Color)
Sets the background color, the shadow is automatically generated.
### Color SetTextColor(Color)
Self explanatory.  Useful if you have a dark button color.
### String SetDText(text)
Sets the title of the button. **Make sure you add the "D", I have that there so that I don't mess with the default label behavior.**
