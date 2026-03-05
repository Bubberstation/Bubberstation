/mob/living/basic/malf_borg/sec
	name = "Malfunctioning Security Cyborg"
	desc = "A security cyborg unit, hacked or malfunctioning. There are two guns attached to it."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_skirmisher

	icon_state = "evilbotsec"
	icon_living = "evilbotsec"
	icon_dead = "evilbotsec"

	exposed_wound_bonus = 0
	sharpness = NONE

	attack_verb_continuous = "gunbutts"
	attack_verb_simple = "gunbutt"
	attack_sound = 'sound/items/weapons/smash.ogg'

	projectiletype = /obj/projectile/bullet/c45
	projectilesound = 'sound/items/weapons/gun/smg/shot.ogg'

/mob/living/basic/malf_borg/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ranged_attacks, projectile_type = projectiletype, projectile_sound = projectilesound)
	ADD_TRAIT(src, TRAIT_SUBTREE_REQUIRED_OPERATIONAL_DATUM, /datum/component/ranged_attacks)
