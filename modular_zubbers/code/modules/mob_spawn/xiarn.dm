/obj/effect/mob_spawn/ghost_role/human/xiarn
	name = "Xiarn sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a Xiarn"
	you_are_text = "You are a Xiarn, a mysterious and enigmatic being."
	flavour_text = "You are a Xiarn, a pacifistic alien species that has been observing the station for some time."
	important_text = "A main ethos of your race is not to harm any living being, though studying them is another matter. Keep in mind you are very weak against burn damage, but stronger against brute."
	mob_species = /datum/species/pod/xiarn
	random_appearance = TRUE
	quirks_enabled = TRUE
	faction = ROLE_SYNDICATE
	restricted_species = list(/datum/species/pod/xiarn)
	var/list/traits = list(TRAIT_PACIFISM, TRAIT_ABDUCTOR_TRAINING)

/obj/effect/mob_spawn/ghost_role/human/xiarn/special(mob/living/carbon/human/new_spawn)
	. = ..()
	if(!new_spawn)
		return
	new_spawn.faction += (ROLE_SYNDICATE)
	new_spawn.add_traits(traits, "xiarn_spawner")

/obj/effect/mob_spawn/ghost_role/human/xiarn/scientist
	name = "Scientist Xiarn sleeper"
	traits = list(TRAIT_PACIFISM, TRAIT_ABDUCTOR_TRAINING, TRAIT_ABDUCTOR_SCIENTIST_TRAINING, TRAIT_SURGEON)
