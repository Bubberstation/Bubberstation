// Removes the accesories button from modsuits. There's a verb in the IC tab
/obj/item/mod/control/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	actions_types -= list(/datum/action/item_action/mod/sprite_accessories,)
	. = ..()
