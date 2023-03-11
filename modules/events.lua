---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local RitnGuiChanger = require(ritnlib.defines.characters.class.guiChanger)
---------------------------------------------------------------------------------------------
local events = {}


local names = {
    ["character"] = {"character-name.Man"},
    ["GearGirl-skin"] = {"character-name.Woman"},
    ["IRobot_character_skin"] = "Robot",
    ["among-us-character-skin"] = "Among Us",
}

  
local function on_init(event)
    global.characters = { 
        modules = {
            player = true,
        }
    }
    
    -- create remote interfaces
    local character_interface = {
        ["gui_action_changer"] = function(action, event)
            if action == ritnlib.defines.characters.gui_actions.changer.open then 
                RitnGuiChanger(event):action_open()
            elseif action == ritnlib.defines.characters.gui_actions.changer.close then 
                RitnGuiChanger(event):action_close()
            elseif action == ritnlib.defines.characters.gui_actions.changer.select then 
                RitnGuiChanger(event):action_select()
            end
        end,
        --disable modules
        ["disable.module.player"] = function()
            global.teleporter.modules.player = false
        end,
        --new characters
        add_character = function(name, skin) 
            local options = remote.call("RitnCoreGame", "get_options")
            table.insert(options.characters, {
                name = name,
                skin = skin,
            })
            remote.call("RitnCoreGame", "set_options", options)
        end,
    }
    remote.add_interface("RitnCharacters", character_interface)
    -------------------------------------------------------------
    remote.call("RitnCoreGame", "add_param_data", "player", "character", {
        index = 0,
        name = 'none',
        skin = 'character'
    })
    ----
    local options = remote.call("RitnCoreGame", "get_options")
    options.characters = {}
    remote.call("RitnCoreGame", "set_options", options)
    ----
    for _,entity in pairs(game.entity_prototypes) do
        if entity.type == "character" then 
            local skin = entity.name
            local name = string.gsub(entity.name, '-', '')
            name = string.gsub(name, '_', '')
            name = string.gsub(name, 'skin', '')
            name = string.gsub(name, 'Skin', '')
            name = string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)

            if names[skin] ~= nil then name = names[skin] end
            remote.call("RitnCharacters", "add_character", name, skin)
        end
    end
end
 


local function on_lua_shortcut(e) 
    RitnGuiChanger(e):on_lua_shortcut()
end
-------------------------------------------
script.on_init(on_init)
-------------------------------------------
events.events = {}
events.events[defines.events.on_lua_shortcut] = on_lua_shortcut
return events