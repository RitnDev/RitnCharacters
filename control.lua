-- Global
require("core.globals")
if not ritnlib then require("__RitnLib__/defines") end

if script.active_mods["gvv"] then require("__gvv__.gvv")() end

-- Chargement de l'event listener :
local event_listener = require(ritnlib.defines.event)
-- envoie des modules à l'event listener :
event_listener.add_libraries(require("core/modules"))
