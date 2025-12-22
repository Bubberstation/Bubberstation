/mob/living/basic/malf_borg/big_guy
	name = "Malfunctioning Military Robot"
	desc = "A military robot unit, hacked or malfunctioning. This one looks really tough."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_skirmisher

	icon_state = "sentrybot"
	icon_living = "sentrybot"
	icon_dead = "sentrybot_d"

	health = 250
	maxHealth = 250

	speed = 0.9

	exposed_wound_bonus = 0
	sharpness = NONE

	attack_verb_continuous = "gunbutts"
	attack_verb_simple = "gunbutt"
	attack_sound = 'sound/items/weapons/smash.ogg'

	projectiletype = /obj/projectile/bullet/c45
	projectilesound = 'sound/items/weapons/gun/smg/shot.ogg'

/mob/living/basic/malf_borg/big_guy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ranged_attacks, projectile_type = projectiletype, projectile_sound = projectilesound)
	ADD_TRAIT(src, TRAIT_SUBTREE_REQUIRED_OPERATIONAL_DATUM, /datum/component/ranged_attacks)
