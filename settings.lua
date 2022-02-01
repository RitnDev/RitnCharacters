
local values = {
    none = "None",
    homme = "Man",
    femme = "Woman",
    robot = "Robot",
    amongUs = "AmongUs",
	shrek = "Shrek",
}


data:extend {
	{
		-- Choix du personnage par defaut
		type = "string-setting",
		name = "ritn-characters-default",
		setting_type = "runtime-global",
		default_value = values.none,
		allowed_values = values,
		order = "ritnmods-characters-01"
	},
	{
		-- Activation du bouton menu
		type = "bool-setting",
		name = "ritn-characters-change",
		setting_type = "startup",
		default_value = true,
		order = "ritnmods-characters-02"
	},
}