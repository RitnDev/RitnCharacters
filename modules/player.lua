-- MODULE : PLAYER
---------------------------------------------------------------------------------------------


local function on_player_created(e) 
    if global.characters.modules.player.complete == false then return end
    if global.characters.modules.player.on_player_created == false then return end
    local rEvent = RitnCoreEvent(e)
    local rPlayer = rEvent:getPlayer()

    if script.level.campaign_name ~= nil then return end
    if script.level.level_name == "wave-defense" then return end
    if script.level.level_name == "pvp" then return end
        
    RitnGuiCharacterChanger(e):action_open()
end



local function on_gui_click(e) 
    if global.characters.modules.player.complete == false then return end
    RitnGuiCharacterChanger(e):on_gui_click()
end



local function on_player_respawned(e)
    if global.characters.modules.player.complete == false then return end
    RitnCharacter(RitnCoreEvent(e).player):check()
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