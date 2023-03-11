---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local RitnGuiChanger = require(ritnlib.defines.characters.class.guiChanger)
---------------------------------------------------------------------------------------------

local function on_init_mod()
    log('RitnCharacters -> on_init !')

    remote.call("RitnCoreGame", "add_param_data", "player", "character", {
        index = 0,
        name = {"character-name.none"},
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
            if string.sub(name, 1, string.len("genshinimpact")) == "genshinimpact" then 
                name = string.gsub(name, 'genshinimpact', '')
                name = name .. ' (Genshin Impact)'
            end
            name = string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)

            if global.characters.names[skin] ~= nil then name = global.characters.names[skin] end
            if name ~= "" then
                remote.call("RitnCharacters", "add_character", name, skin)
            end
        end
    end
    log('on_init : RitnCharacters -> finish !')
end
 


local function on_lua_shortcut(e) 
    RitnGuiChanger(e):on_lua_shortcut()
end
-------------------------------------------
script.on_init(on_init_mod)
-------------------------------------------
local events = { events = {} }
events.events[defines.events.on_lua_shortcut] = on_lua_shortcut
-------------------------------------------
return events