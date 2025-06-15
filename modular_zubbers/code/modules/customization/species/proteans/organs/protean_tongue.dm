/obj/item/organ/tongue/cybernetic/protean
	name = "protean audio fabricator"
	desc = "Millions of nanites vibrate in harmony to create the sound you hear."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/tongue/cybernetic/protean/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/tongue/cybernetic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

