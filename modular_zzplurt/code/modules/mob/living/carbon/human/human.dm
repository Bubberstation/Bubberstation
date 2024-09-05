/mob/living/carbon/human
	/// Are we currently in combat focus?
	var/combat_focus = FALSE

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/skirt_peeking)
