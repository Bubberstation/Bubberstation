/obj/item/mod/module/handle_module_icon(mutable_appearance/standing, module_icon_state)
	. = ..()
	if(!israptor(mod.wearer))
		return
	. = list()
	var/new_icon = 'modular_zubbers/icons/mob/clothing/species/teshari/mod_modules.dmi'
	var/mutable_appearance/module_icon = mutable_appearance(new_icon, module_icon_state, layer = standing.layer + 0.1)
	module_icon.appearance_flags |= RESET_COLOR
	. += module_icon
	return .
