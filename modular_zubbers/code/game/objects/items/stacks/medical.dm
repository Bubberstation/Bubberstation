/obj/item/stack/medical/bone_gel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/bone_gel)

/datum/atom_skin/bone_gel
	abstract_type = /datum/atom_skin/bone_gel

/datum/atom_skin/bone_gel/korve
	preview_name = "korve"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'
	new_icon_state = "bone-gel"

/datum/atom_skin/bone_gel/default
	preview_name = "default"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'
	new_icon_state = "bone-gel"
