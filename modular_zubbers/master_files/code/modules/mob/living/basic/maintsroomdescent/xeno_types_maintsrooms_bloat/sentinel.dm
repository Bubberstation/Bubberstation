/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom
	name = "alien sentinel"
	desc = "An alien that'd be unremarkable if not for the bright coloring and visible acid glands that cover it."
	caste = "sentinel"
	maxHealth = 200
	health = 200
	icon_state = "aliensentinel"
	melee_damage_lower = 10
	melee_damage_upper = 15
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
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/sentinel,
	)
