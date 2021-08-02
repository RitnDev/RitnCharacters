local ship_items = function() return {["firearm-magazine"] = 8} end
local debris_items = function() return {["iron-plate"] = 8} end

local homme = function() return {
    name = "homme",
    skin = "default-character-skin",
} end
local femme = function() return {
    name = "femme",
    skin = "GearGirl-skin",
} end
local robot = function() return {
    name = "robot",
    skin = "IRobot_character_skin",
} end
local amongUs = function() return {
    name = "amongUs",
    skin = "character",
} end
local shrek = function() return {
    name = "shrek",
    skin = "Shrek-skin",
} end

-----------------------------------------------------------------------------------------------
if not global.players then global.players = {} end
if not global.characters then global.characters = {
    femme = femme(),
    homme = homme(),
    robot = robot(),
    amongUs = amongUs(),
    shrek = shrek(),
} end
if not global.crashed_ship_items then global.crashed_ship_items = ship_items() end
if not global.crashed_debris_items then global.crashed_debris_items = debris_items() end