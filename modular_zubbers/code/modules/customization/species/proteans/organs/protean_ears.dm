/obj/item/organ/ears/cybernetic/protean
	name = "sensory nanites"
	desc = "Nanites designed to collect audio feedback from the surrounding world."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/ears/cybernetic/protean/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/ears/cybernetic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

