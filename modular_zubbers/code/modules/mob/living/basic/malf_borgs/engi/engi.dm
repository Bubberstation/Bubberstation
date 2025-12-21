/mob/living/basic/malf_borg/engi
	name = "Malfunctioning Engineering Cyborg"
	desc = "An engineering cyborg unit, hacked or malfunctioning—oh shit that's a plasma bar."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotengi"
	icon_living = "evilbotengi"
	icon_dead = "evilbotengi"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 100
	maxHealth = 100

	melee_damage_type = BURN
	wound_bonus = CANT_WOUND
	exposed_wound_bonus = 0
	sharpness = NONE

	attack_verb_continuous = "welds"
	attack_verb_simple = "weld"
	attack_sound = 'sound/items/tools/welder.ogg'

/mob/living/basic/malf_borg/engi/Initialize(mapload)
	. = ..()
