local folders = {
    ["elements"] = {"frame.lua", "sidebar.lua"},
    ["tests"] = {"init.lua"},
}

local dir = "dynui"

AddCSLuaFile(dir.."/config.lua") 
include(dir.."/config.lua")

if CLIENT then
    DynUI:AddFont("Title",23)
    DynUI:AddFont("Sidebar",20)
end


for fol,files in pairs(folders) do
    for _,fil in ipairs(files) do
       AddCSLuaFile(dir.."/"..fol.."/"..fil)
       if CLIENT then include(dir.."/"..fol.."/"..fil) end
    end
end