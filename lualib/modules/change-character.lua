-- INIT
local util = require(ritnlib.defines.vanilla.util)
local crash_site = require("lualib.vanilla.crash-site")
---------------------------------------------------------------------------------------------
ritnlib.character =     require("lualib.functions.characters")
ritnlib.inventory =     require(ritnlib.defines.inventory)
---------------------------------------------------------------------------------------------
local ritnGui = {}
ritnGui.menu =          require("lualib.gui.menu")
---------------------------------------------------------------------------------------------
local module = {}
module.events = {}


-- Function event
---------------------------------------------------------------------------------------------

local function on_player_joined_game(e)
    local LuaPlayer = game.players[e.player_index]
    if LuaPlayer.connected then
        if not global.players[LuaPlayer.name] then 
            if ritnlib.character.getCharacterName(LuaPlayer) == nil then
                local character = {
                    name = LuaPlayer.name,
                    CharacterName = "",
                    inventories = ritnlib.inventory.init()
                }
                global.players[LuaPlayer.name] = character
                if LuaPlayer.character then 
                    LuaPlayer.character.active = false
                end
                if settings.global["ritn-characters-default"].value == "None" then 
                    ritnGui.menu.open(LuaPlayer)
                else
                    local CharacterName = settings.global["ritn-characters-default"].value
                    ritnlib.character.setCharacterName(LuaPlayer, CharacterName)
                    ritnlib.character.changeCharacter(LuaPlayer, ritnlib.character.getCharacterName(LuaPlayer))
                    ritnGui.menu.close(LuaPlayer)
                    if LuaPlayer.character then 
                        LuaPlayer.character.active = true
                    end
                end
            end
            -- Add Crash site : 
            if not game.active_mods.RitnTeleportation then 
                    crash_site.create_crash_site(LuaPlayer, {-5,-6}, util.copy(global.crashed_ship_items), util.copy(global.crashed_debris_items))
                    util.remove_safe(LuaPlayer, global.crashed_ship_items)
                    util.remove_safe(LuaPlayer, global.crashed_debris_items)
            end
        end
    end
end


local function on_cutscene_cancelled(e)
    local LuaPlayer = game.players[e.player_index]
    on_player_joined_game(e)
end


local function on_gui_click(e)
    local element = e.element
    local parent = element.parent
    local LuaPlayer = game.players[e.player_index]
    local frame = LuaPlayer.gui.center["character-main"]

    if element ~= nil then
        if frame ~= nil then
            if parent.name == frame.name then
                if string.sub(element.name,1,6) == "button" then
                    local CharacterName = string.sub(element.name,8)
                    ritnlib.character.setCharacterName(LuaPlayer, CharacterName)
                    ritnlib.character.changeCharacter(LuaPlayer, ritnlib.character.getCharacterName(LuaPlayer))
                    ritnGui.menu.close(LuaPlayer)
                    if LuaPlayer.character then 
                        LuaPlayer.character.active = true
                    end
                end
            end
        end
    end
end


local function on_player_changed_position(e)
    local LuaPlayer = game.players[e.player_index]
    local frame = LuaPlayer.gui.center["character-main"]
    if frame ~= nil then 
        if LuaPlayer.character then 
            LuaPlayer.character.active = false
        end
    end
end


local function on_player_respawned(e)
    local LuaPlayer = game.players[e.player_index]
    if LuaPlayer.character.name ~= ritnlib.character.getCharacterName(LuaPlayer) then
        ritnlib.character.changeCharacter(LuaPlayer, ritnlib.character.getCharacterName(LuaPlayer))
    end
end


local function on_lua_shortcut(e) 
    local LuaPlayer = game.players[e.player_index]
    local shortcut = e.prototype_name

    if shortcut == "ritnmods-characters-menu" then 
        if LuaPlayer.character then 
            LuaPlayer.character.active = false
        end
        ritnGui.menu.open(LuaPlayer)
    end
end





-- Envoie des scripts
module.events[defines.events.on_player_created]             = on_player_joined_game
module.events[defines.events.on_player_joined_game]         = on_player_joined_game
module.events[defines.events.on_gui_click]                  = on_gui_click
module.events[defines.events.on_player_changed_position]    = on_player_changed_position
module.events[defines.events.on_player_respawned]           = on_player_respawned
module.events[defines.events.on_lua_shortcut]           = on_lua_shortcut
return module