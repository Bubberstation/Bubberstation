/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/drone/maintsroom
	next_evolution = null
	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/large,
		ORGAN_SLOT_XENO_RESINSPINNER = /obj/item/organ/alien/resinspinner,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid,
	)

/mob/living/carbon/alien/adult/skyrat/drone/maintsroom/Initialize(mapload)
	. = ..()

	qdel(GetComponent(/datum/component/itempicky))
