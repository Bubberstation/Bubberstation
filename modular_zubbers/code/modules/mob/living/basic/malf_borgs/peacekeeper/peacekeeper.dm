/mob/living/basic/malf_borg/peace
	name = "Malfunctioning Peacekeeper Cyborg"
	desc = "A cyborg unit, hacked or malfunctioning. This is a Peacekeeper model."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotpeace"
	icon_living = "evilbotpeace"
	icon_dead = "evilbotpeace"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 90
	maxHealth = 90

	melee_damage_type = BRUTE
	wound_bonus = CANT_WOUND
	exposed_wound_bonus = 0
	sharpness = NONE

	attack_verb_continuous = "smacks"
	attack_verb_simple = "smack"
	attack_sound = 'sound/items/weapons/cqchit1.ogg'

/mob/living/basic/malf_borg/peace/Initialize(mapload)
	. = ..()
