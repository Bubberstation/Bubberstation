/datum/species/android/get_species_description()
	return list("Androids are an entirely synthetic species.",)

/obj/item/organ/brain/synth/Initialize(mapload) //speech bubble addition
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "machine", BUBBLE_ICON_PRIORITY_ORGAN)
