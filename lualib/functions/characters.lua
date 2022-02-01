---------------------------------------------------------------------------------------------
-- Fonction "CHARACTER"
---------------------------------------------------------------------------------------------
ritnlib.inventory =     require(ritnlib.defines.inventory)
---------------------------------------------------------------------------------------------
local ritnGui = {}
ritnGui.menu =          require("lualib.gui.menu")
---------------------------------------------------------------------------------------------
local flib = {}


local function changeCharacter(LuaPlayer, CharacterName)
    local LuaSurface = LuaPlayer.surface
    ritnlib.inventory.save(LuaPlayer, global.players[LuaPlayer.name].inventories)
    pcall(function() LuaPlayer.character.destroy() end)
    LuaPlayer.create_character(global.characters[CharacterName].skin)
    ritnlib.inventory.get(LuaPlayer, global.players[LuaPlayer.name].inventories)
end


local function setCharacterName(LuaPlayer, CharacterName)
    for _,player in pairs(global.players) do 
        if player.name == LuaPlayer.name then 
            player.CharacterName = CharacterName
        end
    end
end

local function getCharacterName(LuaPlayer)
    for _,player in pairs(global.players) do 
        if player.name == LuaPlayer.name then 
            return player.CharacterName
        end
    end
end


flib.changeCharacter = changeCharacter
flib.setCharacterName = setCharacterName
flib.getCharacterName = getCharacterName
return flib