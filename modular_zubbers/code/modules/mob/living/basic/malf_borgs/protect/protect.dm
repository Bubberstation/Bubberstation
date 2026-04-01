/mob/living/basic/malf_borg/protect
	name = "Malfunctioning Standard Robot"
	desc = "A civilian model robot, hacked or malfunctioning with mechanical claw arms."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "protectbot"
	icon_living = "protectbot"
	icon_dead = "protectbot"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 100
	maxHealth = 100

	melee_damage_type = BRUTE
	wound_bonus = 5
	exposed_wound_bonus = 2
	sharpness = SHARP_POINTY

	attack_verb_continuous = "claws"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/genhit2.ogg'

/mob/living/basic/malf_borg/protect/Initialize(mapload)
	. = ..()
