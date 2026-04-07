/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom
	name = "alien spitter"
	desc = "A fairly heavy looking alien with prominent acid glands, it's mouth dripping with... some kind of toxin or acid."
	caste = "spitter"
	maxHealth = 300
	health = 300
	icon_state = "alienspitter"
	melee_damage_lower = 15
	melee_damage_upper = 20
	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = null,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/spitter,
	)
