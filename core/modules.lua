local modules = {}
------------------------------------------------------------------------------

-- Inclus les events onInit et onLoad + les ajouts de commandes
modules.events =                require(ritnlib.defines.characters.modules.events)

---- Modules désactivable
modules.player =                require(ritnlib.defines.characters.modules.player) 
------------------------------------------------------------------------------
return modules