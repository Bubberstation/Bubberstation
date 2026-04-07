/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/defender/maintsroom
	name = "alien defender"
	desc = "A heavy looking alien with a wrecking ball-like tail that'd probably hurt to get hit by."
	caste = "defender"
	maxHealth = 300
	health = 300
	icon_state = "aliendefender"
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
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/small,
	)
