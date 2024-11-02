if not ritnlib then require("__RitnLib__/defines") end
require("core.defines")
require(ritnlib.defines.fonts) -- FONTS
-- sprite du shortcut
local sprite_icon_shortcut = {
    type = "sprite",
    filename = ritnlib.defines.characters.graphics.shortcut,
    size = 64,
    flags = {"icon"}
}
-- shortcut action
local shortcut = {
    type = "shortcut",
    name = ritnlib.defines.characters.names.shortcut,
    action = "lua",
    icon = ritnlib.defines.characters.graphics.shortcut,
    icon_size = 64,
    small_icon = ritnlib.defines.characters.graphics.shortcut,
    small_icon_size = 64,
    toggleable = true,
}
-- activate shortcut
local active_shortcut = settings.startup[ritnlib.defines.characters.settings.change.name].value
if active_shortcut then data:extend({shortcut}) end