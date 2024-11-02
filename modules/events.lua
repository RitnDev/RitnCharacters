---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local function init_characters()
    -- prepare options characters list
    local options = remote.call("RitnCoreGame", "get_options")
    options.characters = {}
    remote.call("RitnCoreGame", "set_options", options)

    -- add characters on list
    for _,entity in pairs(game.entity_prototypes) do
        if entity.type == "character" then 
            local skin = entity.name
            local name = string.gsub(entity.name, '-skin', '')
            name = string.gsub(name, '-', ' ')
            name = string.gsub(name, '_', ' ')
            name = string.gsub(name, 'skin', '')
            name = string.gsub(name, 'character', '')
            name = string.gsub(name, 'Skin', '')
            if string.sub(name, 1, string.len("genshinimpact")) == "genshinimpact" then 
                name = string.gsub(name, 'genshinimpact', '')
                name = name .. ' (Genshin Impact)'
            end
            name = string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)

            if storage.characters.names[skin] ~= nil then name = storage.characters.names[skin] end
            if name ~= "" then
                remote.call("RitnCharacters", "add_character", name, skin)
            end
        end
    end
end


local function on_init_mod()
    log('RitnCharacters -> on_init !')
    ---------------------------------------------
    local enemy = remote.call('RitnCoreGame', 'get_enemy')
    if enemy.force_disable ~= nil then 
        enemy.force_disable = false
    end
    remote.call('RitnCoreGame', "set_enemy", enemy)
    ---------------------------------------------
    remote.call("RitnCoreGame", "add_param_data", "player", "character", {
        index = 0,
        name = {"character-name.none"},
        skin = 'character',
    })
    ---------------------------------------------
    init_characters()
    ---------------------------------------------
    log('on_init : RitnCharacters -> finish !')
end


local function on_configuration_changed()
    local enemy = remote.call('RitnCoreGame', 'get_enemy')
    if enemy.force_disable == nil then 
        enemy.force_disable = false
        remote.call('RitnCoreGame', "set_enemy", enemy)
    end
    
    if storage.players ~= nil then storage = {} end
    if storage.characters == nil then 
        storage.characters = { 
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
    elseif ritnlib.defines.characters.version == "1.2.6" then 
        log('>>> Migration mod RitnCharacters_1.2.6 <<<')
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
    init_characters()
end


local function on_lua_shortcut(e) 
    if storage.characters.modules.on_lua_shortcut == false then return end
    RitnGuiCharacterChanger(e):on_lua_shortcut()
end


-------------------------------------------
local module = { events = {} }
-------------------------------------------
module.on_init = on_init_mod
module.on_configuration_changed = on_configuration_changed
module.events[defines.events.on_lua_shortcut] = on_lua_shortcut
-------------------------------------------
return module