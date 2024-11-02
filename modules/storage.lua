---------------------------------------------------------------------------------------------
-- GLOBALS
---------------------------------------------------------------------------------------------
if storage.characters == nil then 
    storage.characters = { 
        modules = {
            player = {
                on_player_created = true,
                complete = true,
            },
            on_lua_shortcut = true,
        },
        names = {
            ["character"] = {"character-name.Man"},
            ["GearGirl-skin"] = {"character-name.Woman"},
            ["IRobot_character_skin"] = "Robot",
            ["among-us-character-skin"] = "Among Us",
            ["minime_character_dummy"] = "",
        },
        version = ritnlib.defines.characters.version
    }
end

---------------------------------------------------------------------------------------------
-- REMOTE FUNCTIONS INTERFACE
---------------------------------------------------------------------------------------------
local character_interface = {

    ["gui_action_changer"] = function(action, event)
        if action == ritnlib.defines.characters.gui_actions.changer.open then 
            RitnGuiCharacterChanger(event):action_open()
        elseif action == ritnlib.defines.characters.gui_actions.changer.close then 
            RitnGuiCharacterChanger(event):action_close()
        elseif action == ritnlib.defines.characters.gui_actions.changer.select then 
            RitnGuiCharacterChanger(event):action_select()
        end
    end,

    --disable modules
    ["disable.module.player"] = function()
        storage.teleporter.modules.player.complete = false
    end,
    ["disable.module.on_player_created"] = function()
        storage.teleporter.modules.player.on_player_created = false
    end,
    ["disable.module.on_lua_shortcut"] = function()
        storage.teleporter.modules.on_lua_shortcut = false
    end,
    
    --new character
    add_character = function(name, skin) 
        local options = remote.call("RitnCoreGame", "get_options")
        table.insert(options.characters, {
            name = name,
            skin = skin,
        })
        remote.call("RitnCoreGame", "set_options", options)
    end,
    -- remove character
    remove_character = function(skin) 
        local options = remote.call("RitnCoreGame", "get_options")
        local position = 0
        for index, character in pairs(options.characters) do
            if character.skin == skin then 
                position = index
            end
        end
        if position > 0 then 
            table.remove(options.characters, position)
        end
        remote.call("RitnCoreGame", "set_options", options)
    end,
}
---------------------------------------------------------------------------------------------
remote.add_interface("RitnCharacters", character_interface)
---------------------------------------------------------------------------------------------
return {}