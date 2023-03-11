require('core.defines')

data:extend {
	{
		-- Activation du bouton menu
		type = "bool-setting",
		name = ritnlib.defines.characters.settings.change.name,
		setting_type = "startup",
		default_value = ritnlib.defines.characters.settings.change.value,
		order = ritnlib.defines.characters.settings.change.order,
	},
}