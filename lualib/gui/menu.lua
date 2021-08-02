---------------------------------------------------------------------------------------------
--  GUI "Menu"
---------------------------------------------------------------------------------------------
local ritnlib = {}
ritnlib.gui =      require("lualib.functions.gui")
---------------------------------------------------------------------------------------------

local LuaGui = {}

local function create(LuaPlayer)
    local center = LuaPlayer.gui.center
    local content = {}

    content.main = ritnlib.gui.createFrame(
        center,
        "character-main",
        {"main-frame.character-main"}
    )

    for _,char in pairs(global.characters) do
        local buttonName = "button-" .. char.name
        content[buttonName] = ritnlib.gui.createButton(
            content.main,
            buttonName,
            {"main-frame." .. buttonName}
        )
        content[buttonName].style.minimal_height = 35
        content[buttonName].style.minimal_width = 180
    end

end



local function close(LuaPlayer)
    local center = LuaPlayer.gui.center
    local guiFrame = center["character-main"]

    if guiFrame then 
        guiFrame.destroy()
    end
end 


local function open(LuaPlayer) 
    close(LuaPlayer)
    create(LuaPlayer)
end





LuaGui.open = open
LuaGui.close = close
return LuaGui