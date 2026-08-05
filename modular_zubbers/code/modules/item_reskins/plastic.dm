/obj/item/grenade/c4/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/c4)

/datum/atom_skin/c4
	abstract_type = /datum/atom_skin/c4

/datum/atom_skin/c4/moth
	preview_name = "Moth"
	new_icon = 'modular_zubbers/icons/obj/equipment/mothbomb.dmi'
	new_icon_state = "moffplush_bomb"

/datum/atom_skin/c4/default
	preview_name = "C4"
	new_icon_state = "plastic-explosive0"
