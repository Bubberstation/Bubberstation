// Element added to some Protean organs.

/datum/element/nanite_organ
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

/datum/element/nanite_organ/Attach(obj/item/organ/target)
	. = ..()
	if(!istype(target) || (target.organ_flags & ORGAN_EXTERNAL))
		return ELEMENT_INCOMPATIBLE

	if(!istype(target, /obj/item/organ/eyes))
		target.add_atom_colour(COLOR_GRAY, FIXED_COLOUR_PRIORITY) // Does a tree scream in the woods? More importantly, can you see the color of an organ that deletes itself?

