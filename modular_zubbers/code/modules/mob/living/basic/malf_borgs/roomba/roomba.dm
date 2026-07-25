/mob/living/basic/malf_borg/roomba
	name = "Malfunctioning Roomba Cyborg"
	desc = "A roomba, hacked or malfunctioning—OW MY FOOT!"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	icon_state = "evilbotroomba"
	icon_living = "evilbotroomba"
	icon_dead = "evilbotroomba"

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	health = 80
	maxHealth = 80

	speed = 1.2

	melee_damage_type = BRUTE
	wound_bonus = 6
	exposed_wound_bonus = 3
	sharpness = SHARP_POINTY

	attack_verb_continuous = "pokes"
	attack_verb_simple = "stab"
	attack_sound = 'sound/items/weapons/genhit2.ogg'

/mob/living/basic/malf_borg/roomba/Initialize(mapload)
	. = ..()
