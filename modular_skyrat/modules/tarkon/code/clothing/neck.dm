/obj/item/clothing/neck/security_cape/tarkon
	name = "tarkon protection gauntlet"
	desc = "A full-arm gauntlet used by Tarkon Industries to protect the main tool-arm of its employee's. Not that useful in a real fight, however."
	worn_icon = 'modular_skyrat/modules/tarkon/icons/mob/clothing/neck.dmi'
	icon = 'modular_skyrat/modules/tarkon/icons/obj/clothing/neck.dmi'
	icon_state = "armplate_shemaugh"

/obj/item/clothing/neck/security_cape/tarkon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tarkon_gauntlet)

/datum/atom_skin/tarkon_gauntlet
	abstract_type = /datum/atom_skin/tarkon_gauntlet

/datum/atom_skin/tarkon_gauntlet/caped
	preview_name = "Caped Variant"
	new_icon_state = "armplate_shemaugh"

/datum/atom_skin/tarkon_gauntlet/capeless
	preview_name = "Capeless Variant"
	new_icon_state = "armplate"
