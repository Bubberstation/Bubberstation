/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom
	name = "alien warrior"
	desc = "If there are aliens to call walking tanks, this would be one of them, with both the heavy armor and strong arms to back that claim up."
	caste = "warrior"
	maxHealth = 400
	health = 400
	icon_state = "alienwarrior"
	melee_damage_lower = 30
	melee_damage_upper = 35
	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = null,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel,
	)
