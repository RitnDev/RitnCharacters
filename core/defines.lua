-----------------------------------------
--               DEFINES               --
-----------------------------------------
if not ritnlib then ritnlib = { defines={} } end
local name = "RitnCharacters"
local dir = "__".. name .."__"
local directory = dir .. "."


local defines = {}

-- Mod ID.
defines.name = name
-- Path to the mod's directory.
defines.directory = dir
defines.version = "1.2.4"


-- classes
defines.class = {
    character = dir .. ".classes.RitnCharacter",
    ----
    guiChanger = dir .. ".classes.RitnGuiChanger",
}


-- Modules
defines.modules = {
    core = dir .. ".core.modules",
    globals = dir .. ".modules.globals",
    events = dir .. ".modules.events",
    interfaces = dir .. ".modules.interfaces",
    ----
    player = dir .. ".modules.player",
    ----
    changeCharacter = dir .. ".lualib.modules.change-character"
}


-- graphics
local graphics = dir .. "/graphics/"
local gui = graphics .. "gui/"
defines.graphics = {
    shortcut = graphics .. "shortcut.png",
}

-- Prefix
defines.prefix = {
    name = "ritnmods-",
    mod = "characters-",
}


-- gui
defines.gui = {}
local dir_gui = directory .. "gui."
---------------------------
defines.gui.changer = dir_gui .. "changer"
---------------------------


defines.gui_actions = {
    changer = {
        open = "open",
        close = "close",
        select = "button-select",
    },
}

--settings 
local settings_prefix = defines.prefix.name .. defines.prefix.mod
defines.settings = {
    change = {
        name = settings_prefix .. "change",
        value = true, 
        order = settings_prefix .. "00"
    },
    default = {
        name = settings_prefix .. "default",
        value = true, 
        order = settings_prefix .. "01"
    },
}


-- Name and value
defines.names = {
    shortcut = "ritnmods-characters-menu",   
}


-- GUI element captions.
defines.names.caption = {
    frame_changer = {
        titre = {"frame-changer.title"},
        button_select = {"frame-changer.button-select"}
    }
}

----------------
ritnlib.defines.characters = defines
log('declare : ritnlib.defines.characters | '.. ritnlib.defines.characters.name ..' -> finish !')