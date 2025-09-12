/obj/item/organ/eyes/robotic/protean
	name = "imaging nanites"
	desc = "Nanites designed to collect visual data from the surrounding world."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)

