---------------------------------------------------------------------------------------------
-- GLOBALS
---------------------------------------------------------------------------------------------
local RitnGuiChanger = require(ritnlib.defines.characters.class.guiChanger)
---------------------------------------------------------------------------------------------
if global.characters == nil then 
    global.characters = { 
        modules = {
            player = true,
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
---------------------------------------------------------------------------------------------
remote.add_interface("RitnCharacters", character_interface)
---------------------------------------------------------------------------------------------
return {}