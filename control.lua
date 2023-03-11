-- Global
require("core.globals")
-- defines
if not ritnlib then require("__RitnLib__/defines") end
require("__RitnCoreGame__.core.defines")
require("__RitnBaseGame__.core.defines")
require("__RitnCharacters__.core.defines")

-- Activation de gvv s'il est présent
if script.active_mods["gvv"] then require(ritnlib.defines.gvv)() end
-- envoie des modules à l'event listener :
local listener = require(ritnlib.defines.event).add_libraries(require(ritnlib.defines.characters.modules.core))