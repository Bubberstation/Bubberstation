/// MAINTSROOMS FREINDBENOS

/mob/living/carbon/alien/adult/skyrat/runner/maintsroom
	name = "alien runner"
	desc = "A short alien with sleek red chitin, clearly abiding by the 'red ones go faster' theorem and almost always running on all fours."
	caste = "runner"
	maxHealth = 150
	health = 150
	icon_state = "alienrunner"
	/// Holds the evade ability to be granted to the runner later
	var/datum/action/cooldown/alien/skyrat/evade/evade_ability
	melee_damage_lower = 15
	melee_damage_upper = 20
	next_evolution = null
	on_fire_pixel_y = 0
	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = null,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/small/tiny,
	)
