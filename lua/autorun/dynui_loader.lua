local dir = "dynui"

AddCSLuaFile(dir.."/config.lua") 
include(dir.."/config.lua")

local folders = {
    ["elements"] = {
        "frame.lua", 
        "sidebar.lua", 
        "button.lua", 
        "switch.lua", 
        "tooltip.lua", 
        "scrollpanel.lua", 
        "textentry.lua", 
        "collapsiblecategory.lua"
    },
    ["tests"] = {"init.lua"},
}

if CLIENT then
    DynUI:AddFont("Title",23)
    DynUI:AddFont("Sidebar",20)
    DynUI:AddFont("Button",17, 100)
    DynUI:AddFont("Tooltip",15, 100)
    DynUI:AddFont("Query_Title",28)
else
    for _,v in ipairs(file.Find("sound/dynui/*", "GAME")) do
        resource.AddFile("sound/dynui/"..v)
    end
    -- Sidebar Icons (Should be packaged with whatever addon you're making)
    resource.AddFile("materials/dynui/cog_placeholder.png")
    resource.AddFile("materials/dynui/house_placeholder.png")
    resource.AddFile("materials/dynui/loader2.png")
end


for fol,files in pairs(folders) do
    for _,fil in ipairs(files) do
       AddCSLuaFile(dir.."/"..fol.."/"..fil)
       if CLIENT then include(dir.."/"..fol.."/"..fil) end
    end
end
