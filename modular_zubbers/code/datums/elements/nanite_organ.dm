// Element added to some Protean organs.

/datum/element/nanite_organ

/datum/element/nanite_organ/Attach(obj/item/organ/target)
	. = ..()
	if(!istype(target) || (target.organ_flags & ORGAN_EXTERNAL))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ORGAN_REMOVED, PROC_REF(on_removed))
	target.add_atom_colour(COLOR_GRAY, FIXED_COLOUR_PRIORITY) // Does a tree scream in the woods? More importantly, can you see the color of an organ that deletes itself?

/datum/element/nanite_organ/Detach(datum/source)
	UnregisterSignal(COMSIG_ORGAN_REMOVED)
	return ..()

/datum/element/nanite_organ/proc/on_removed(atom/organ)
	SIGNAL_HANDLER

	organ.balloon_alert_to_viewers("the organ melts into metallic slop")
	qdel(organ)
