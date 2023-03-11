-- MODULE : PLAYER
---------------------------------------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnGuiChanger = require(ritnlib.defines.characters.class.guiChanger)
local RitnCharacter = require(ritnlib.defines.characters.class.character)
---------------------------------------------------------------------------------------------


local function on_player_created(e) 
    if global.characters.modules.player == false then return end
    local rEvent = RitnEvent(e)
    local rPlayer = rEvent:getPlayer()

    if script.level.campaign_name ~= nil then return end
    if script.level.level_name == "wave-defense" then return end
    if script.level.level_name == "pvp" then return end
        
    RitnGuiChanger(e):action_open()
end



local function on_gui_click(e) 
    if global.characters.modules.player == false then return end
    RitnGuiChanger(e):on_gui_click()
end



local function on_player_respawned(e)
    if global.characters.modules.player == false then return end
    RitnCharacter(RitnEvent(e).player):check()
end


---------------------------------------------------------------------------------------------
local module = {events = {}}
---------------------------------------------------------------------------------------------
-- Events Player
module.events[defines.events.on_player_created] = on_player_created
module.events[defines.events.on_gui_click] = on_gui_click
module.events[defines.events.on_player_respawned] = on_player_respawned
---------------------------------------------------------------------------------------------
return module