# DynUI
This library includes components very similar to the default VGUI components (like "DFrame" and "DButton"), but they actually look good (thank god). 
They also have some unique cases that you'll have to pay attention to when using this library.

# Standards
## Branches
Utilize new branches branch to make new commits. Once you have reviewed your own code, create a pull request to be reviewed by JoshJOkayguy which (if accepted) will be merged into the `main` branch.

## Naming convention
All variables that are used more than once should be named using PascalCase, if it's a minor value that only gets used once right after declaration it may be in snake_case.
## Commit messages
Commits from this point forwards should begin with the type of commit (feat for features, fix for bug fixes, etc.) then a descriptive yet brief commit message. If more is needed utilize commit descriptions.

# Components
## DynFrame
### Methods
#### void `DoHeader()`
Whether or not to draw the header.
#### void `SetTitle(title)`
Sets the title.
#### boolean `SetBlur(blur)`
Blur: Whether or not to blur the background behind the frame. Leave empty or falsy to return current blur value.
#### void `Minimize(minimize)`
Minimize: (boolean) True to minimize, false to maximize.
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
#### void `AddTab(name, material, first)`
Name: Name of the tab to reference by as well as what shows up in the menu.<br>
Material: Material for the icon using the Material() function. Can not be nil.<br>
First: Whether or not this is the tab you want to be already active when the menu first opens. **DO NOT SET THIS TO TRUE ON MULTIPLE TABS**

## DynButton
### Details
There is currently a bug where you can't make the buttons too tall or else they will look weird [github issue with image](https://github.com/dynamicdevsgmod/DynUI/issues/1). Sorry but I don't have a fix right now, and frankly the buttons should never be that big anyways.

### Methods
#### Color `SetColor(Color)`
Sets the background color, the shadow is automatically generated.
### Color `SetTextColor(Color)`
Self explanatory.  Useful if you have a dark button color.
### String `SetDText(text)`
Sets the title of the button. **Make sure you add the "D", I have that there so that I don't mess with the default label behavior.**

## DynSwitch
### Details
A toggleable switch.

### Methods
#### Boolean `DoToggle(boolean)`
Determines whether or not to start the switch toggled. Not required. If no arguments are passed (or the argument is falsy) it will simply return whether or not
the switch is toggled, like a "Get" function.

## Tooltips
### Details
Pretty tooltips that appear when certain elements are hovered. Attach it to an element using the following method.
### Methods
#### void `DynUI:MakeTooltip(frame, element, message, width)`
Frame: Usually the "main" panel. The tooltip just needs a place to live. In a normal UI workflow, we would place this within the tab (see above) that we want it to appear in. <br>
Element: The element that we want the tooltip to appear on when we hover. <br>
Message: The message that you want to appear when the tooltip is activated. <br>
Width (optional*): Sets the width of the tooltip. *If the message takes up more than 100 pixels of width, you need to set this to accomadate for the extra space. <br>
**Note: Does NOT support multiple lines or super fucking long messages, use a notification or something if you need to say something
big. <br>
Note 2: Usually 20 pixels of horizontal padding works best when setting the width.**

## Text Entries
### Details
Most of the normal DTextEntry functions that you actually use will be available to use on this. If it's not and you need it, make a feature request or some shit.
### Methods
#### Color/void <Set/Get>AccentColor(color/nil)
Sets/Gets the color of the accent bar on the bottom of the text entry.


## Confirmation prompts (Derma_Query() clone)
### Details
Similar to derma query, creates a new "confirmation prompt" with customizable text that accepts callbacks when confirmed.
### Methods
#### Panel DynUI:ConfirmAction(ttl, text, callback, closecallback)
ttl: The title at the top of the frame, if nil the text will default to "Are You Sure?" <br>
text: The text in the center of the frame, make this concise yet clear. If nil the text will default to "Please confirm this action." <br>
callback: The callback for when the "Confirm Action" button is clicked.<br>
closecallback: Same thing as above but for when the "cancel" button is clicked. Both of these options aren't required but it
s pointless not to have at least one of them.<br><br>
Returns the frame that the prompt is held within.