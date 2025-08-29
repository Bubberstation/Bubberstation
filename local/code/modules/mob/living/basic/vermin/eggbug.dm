/// to the dopefish of the modern era
/mob/living/basic/eggbug
	name = "eggbug"
	desc = "A long-forgotten creature that defies all logic of \"shading\" and \"adhering to properties of light.\" Is it a bug; or is it an egg?"
	icon = 'local/icons/mob/simple/animal.dmi'
	icon_state = "eggbug"
	icon_living = "eggbug"
	icon_dead = "eggbug_dead"
	maxHealth = 10
	health = 10
	attack_verb_continuous = "chosts"
	attack_verb_simple = "chost"
	butcher_results = list(/obj/item/food/egg = 1)
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC | MOB_BUG

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "splats"
	response_harm_simple = "splat"

	ai_controller = /datum/ai_controller/basic_controller/eggbug

/mob/living/basic/eggbug/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/ai_controller/basic_controller/eggbug
	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
