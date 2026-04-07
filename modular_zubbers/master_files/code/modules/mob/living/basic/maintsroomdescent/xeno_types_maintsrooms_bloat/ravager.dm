/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom
	name = "alien ravager"
	desc = "An alien with angry red chitin, with equally intimidating looking blade-like claws in place of normal hands. That sharp tail looks like it'd probably hurt."
	caste = "ravager"
	maxHealth = 350
	health = 350
	icon_state = "alienravager"
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
