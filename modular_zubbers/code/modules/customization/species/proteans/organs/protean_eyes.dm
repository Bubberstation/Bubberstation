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

