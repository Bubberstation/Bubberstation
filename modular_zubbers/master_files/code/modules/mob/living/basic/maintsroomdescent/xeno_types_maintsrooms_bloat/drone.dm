/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/drone/maintsroom
	name = "alien drone"
	desc = "As plain looking as you could call an alien with armored black chitin and large claws."
	caste = "drone"
	maxHealth = 200
	health = 200
	icon_state = "aliendrone"
	melee_damage_lower = 15
	melee_damage_upper = 20
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
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid,
	)
