// Element added to some Protean organs.

/datum/element/nanite_organ
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

/datum/element/nanite_organ/Attach(obj/item/organ/target)
	. = ..()
	if(!istype(target) || (target.organ_flags & ORGAN_EXTERNAL))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ORGAN_REMOVED, PROC_REF(on_removed))
	if(!istype(target, /obj/item/organ/eyes))
		target.add_atom_colour(COLOR_GRAY, FIXED_COLOUR_PRIORITY) // Does a tree scream in the woods? More importantly, can you see the color of an organ that deletes itself?

/datum/element/nanite_organ/Detach(datum/source)
	. = ..()
	UnregisterSignal(COMSIG_ORGAN_REMOVED)

/datum/element/nanite_organ/proc/on_removed(atom/organ)
	SIGNAL_HANDLER

	if(QDELETED(organ))
		return

	QDEL_IN(organ, 5 SECONDS)
