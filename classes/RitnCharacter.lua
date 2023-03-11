-- RitnCharacter
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local libPlayer = require(ritnlib.defines.class.luaClass.player)
local RitnInventory = require(ritnlib.defines.class.ritnClass.inventory)
----------------------------------------------------------------


----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnCharacter = class.newclass(libPlayer, function(base, LuaPlayer)
    libPlayer.init(base, LuaPlayer)
    base.object_name = "RitnCharacter"
    ----
    local players = remote.call("RitnCoreGame", "get_players")
    base.data = players[base.index]   
    ----
    local options = remote.call("RitnCoreGame", "get_options")
    base.characters = options.characters
    --------------------------------------------------
end)

----------------------------------------------------------------


function RitnCharacter:change(index_character)
    if index_character == 0 then return self end
    local inventories = {}
    local rInventory = RitnInventory(self.player, inventories)
    rInventory:save(true)
    ----
    self:destroy()
    self.player.create_character(self.characters[index_character].skin)
    ----
    rInventory:load(true)
    ----
    self.data.character = {
        index = index_character,
        name = self.characters[index_character].name,
        skin = self.characters[index_character].skin,
    }
    self:update()
end



function RitnCharacter:destroy()
    pcall(function() self.character.destroy() end)
    return self
end



function RitnCharacter:set(character)
    self.data.character = character
    self:update()
    return self
end



function RitnCharacter:get()
    return self.data.character
end



function RitnCharacter:check()
    if self.character.name ~= self:get() then
        self:change(self.data.character.index)
    end
end



function RitnCharacter:update()
    local players = remote.call("RitnCoreGame", "get_players")
    players[self.index] = self.data
    remote.call("RitnCoreGame", "set_players", players)

    return self
end

----------------------------------------------------------------
return RitnCharacter