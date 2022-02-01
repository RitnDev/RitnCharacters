local ship_items = function() return {["firearm-magazine"] = 8} end
local debris_items = function() return {["iron-plate"] = 8} end

local homme = function() return {
    name = "Man",
    skin = "character",
} end
local femme = function() return {
    name = "Woman",
    skin = "GearGirl-skin",
} end
local robot = function() return {
    name = "Robot",
    skin = "IRobot_character_skin",
} end
local amongUs = function() return {
    name = "AmongUs",
    skin = "among-us-character-skin",
} end
local shrek = function() return {
    name = "Shrek",
    skin = "Shrek-skin",
} end

-----------------------------------------------------------------------------------------------
if not global.players then global.players = {} end
if not global.characters then global.characters = {
    Woman = femme(),
    Man = homme(),
    Robot = robot(),
    AmongUs = amongUs(),
    Shrek = shrek(),
} end
if not global.crashed_ship_items then global.crashed_ship_items = ship_items() end
if not global.crashed_debris_items then global.crashed_debris_items = debris_items() end
