/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom
	name = "alien praetorian"
	desc = "An alien that looks like the awkward half-way point between a queen and a drone, in fact that's likely what it is."
	caste = "praetorian"
	maxHealth = 400
	health = 400
	icon_state = "alienpraetorian"
	melee_damage_lower = 25
	melee_damage_upper = 30
	next_evolution = null
	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = /obj/item/organ/alien,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/large,
		ORGAN_SLOT_XENO_RESINSPINNER = /obj/item/organ/alien/resinspinner,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/spitter,
	)
