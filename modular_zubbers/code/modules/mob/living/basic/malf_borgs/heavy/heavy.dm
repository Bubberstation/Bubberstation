/mob/living/basic/malf_borg/heavy
	name = "Malfunctioning Heavy Cyborg"
	desc = "A large cyborg unit, hacked or malfunctioning. It—oh my god is that a chainsaw?!"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotheavy"
	icon_living = "evilbotheavy"
	icon_dead = "evilbotheavy"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 125
	maxHealth = 125

	speed = 0.85

	melee_damage_type = BRUTE
	wound_bonus = 25
	exposed_wound_bonus = 15
	sharpness = SHARP_EDGED

	attack_verb_continuous = "saws"
	attack_verb_simple = "saw"
	attack_sound = 'sound/items/weapons/chainsawhit.ogg'

/mob/living/basic/malf_borg/heavy/Initialize(mapload)
	. = ..()
