-- sprit du shortcut
local sprite_icon_shortcut = {
    type = "sprite",
    filename = "__RitnCharacters__/graphics/shortcut.png",
    size = 64,
    flags = {"icon"}
}


local active_shortcut = settings.startup["ritn-characters-change"].value

if active_shortcut then

    -- add shortcut
    data:extend({
        {
        type = "shortcut",
        name = "ritnmods-characters-menu",
        action = "lua",
        icon = sprite_icon_shortcut,
        toggleable = true,
        },
    })

end