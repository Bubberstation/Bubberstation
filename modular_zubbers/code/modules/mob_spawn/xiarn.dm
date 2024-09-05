#define RADIO_CHANNEL_XIARN "Xiarn"
#define RADIO_KEY_XIARN "x"
#define RADIO_TOKEN_XIARN ":f"

/datum/job/ghost_role/xiarn
	title = "Xiarn"
	supervisors = "your Xiarn Captain"
	faction = list(ROLE_SYNDICATE)
	job_spawn_title = "Xiarn Grunt"

/datum/job/ghost_role/xiarn/scientist
	title = "Xiarn Scientist"
	job_spawn_title = "Xiarn Scientist"
	faction = list(ROLE_SYNDICATE)

/obj/effect/mob_spawn/ghost_role/human/xiarn
	name = "Xiarn sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a Xiarn"
	you_are_text = "You are a Xiarn."
	flavour_text = "You are a Xiarn, a pacifistic alien species that has been observing the station for some time."
	important_text = "A main ethos of your race is not to harm any living being, though studying them is another matter. Keep in mind you are very weak against burn damage, but stronger against brute."
	mob_species = /datum/species/pod/xiarn
	spawner_job_path = /datum/job/ghost_role/xiarn
	random_appearance = TRUE
	quirks_enabled = TRUE
	restricted_species = list(/datum/species/pod/xiarn)
	var/list/traits = list(TRAIT_PACIFISM, TRAIT_ABDUCTOR_TRAINING)
	var/antag_type = /datum/antagonist/xiarn

/obj/effect/mob_spawn/ghost_role/human/xiarn/special(mob/living/carbon/human/new_spawn)
	. = ..()
	if(!new_spawn)
		return
	new_spawn.mind.add_antag_datum(antag_type)
	new_spawn.add_traits(traits, "xiarn_spawner")

/obj/effect/mob_spawn/ghost_role/human/xiarn/scientist
	name = "Scientist Xiarn sleeper"
	spawner_job_path = /datum/job/ghost_role/xiarn/scientist
	traits = list(TRAIT_PACIFISM, TRAIT_ABDUCTOR_TRAINING, TRAIT_ABDUCTOR_SCIENTIST_TRAINING, TRAIT_SURGEON)

/datum/antagonist/xiarn
	name = "Xiarn"
	show_to_ghosts = TRUE
	suicide_cry = "FOR PEACE!"
	antagpanel_category = "Kidnappers"
