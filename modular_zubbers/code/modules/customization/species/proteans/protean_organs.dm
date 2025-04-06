/obj/item/organ/heart/protean
	name = "orchestrator module"
	desc = "A small computer, designed for highly parallel workloads."
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "orchestrator"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE

/obj/item/organ/eyes/robotic/protean
	name = "imaging nanites"
	desc = "Nanites designed to collect visual data from the surrounding world"
	organ_flags = ORGAN_ROBOTIC
	flash_protect = FLASH_PROTECTION_WELDER

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

/obj/item/organ/ears/cybernetic/protean
	name = "sensory nanites"
	desc = "Nanites designed to collect audio feedback from the surrounding world"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/ears/cybernetic/protean/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/ears/cybernetic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

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

