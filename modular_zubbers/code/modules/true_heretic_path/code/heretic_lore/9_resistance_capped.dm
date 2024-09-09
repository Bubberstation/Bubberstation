/datum/heretic_knowledge/ultimate/exile_final
	name = "Exile's Ascension"
	desc = "The ascension ritual of the Path of Exile. \
	Bring 3 corpses belonging to high-value targets, such as a Head of Staff or a Captain, to a transmutation rune to complete the ritual. \
	When completed, you become highly resistant to damage, and recieve upgrades in some of your main-path exile abilities. \
	Additionally, most of the objects on the station become... magical."
	gain_text = "Much like the Exile before me, I have seeked revenge against those who exiled me. \
	Now that I have returned to full power, none can stop me. I am free to raze and pillage this place as I see fit, \
	a true reward for someone returning from the Path of Exile."
	route = PATH_EXILE

	ascension_achievement = /datum/award/achievement/misc/exile_ascension

/datum/heretic_knowledge/ultimate/exile_final/is_valid_sacrifice(mob/living/sacrifice)
	return HAS_TRAIT(sacrifice,TRAIT_HIGH_VALUE_RANSOM)

/datum/heretic_knowledge/ultimate/exile_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	//Give the user some damage resist.
	if(ishuman(user))
		//With the base damage resistance from ascending, this should equal the equivilent of 75% damage resist (0.5 * 0.5 = 0.25)
		var/mob/living/carbon/human/human_user = user
		human_user.physiology.brute_mod *= 0.5
		human_user.physiology.burn_mod *= 0.5
		//Tox mod not included here because who caps their chaos resist lol lmao

	//Run the actual heretic ascension event.
	//Yes, this will spawn crazy modifiers on items.
	//Yes, I might regret this.
	var/datum/round_event_control/wizard/rpgloot/loot_event = locate() in SSevents.control
	loot_event.run_event(event_cause = "heretic ascension")

	//I've come to make an announcement.
	priority_announce(
		text = "[generate_heretic_text()] The avenged exile [user.real_name] has ascended. Woe to all that may try to stop their vengeance, for it is already complete! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = 'modular_zubbers/sound/ambience/antag/heretic/ascend_exile.ogg',
		color_override = "purple",
	)

	var/obj/item/paper/fluff/patch_notes/muh_immersion = new(loc)
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		human_user.put_in_hands(muh_immersion)

/datum/heretic_knowledge/ultimate/exile_final/cleanup_atoms(list/selected_atoms)

	for(var/mob/living/carbon/human/sacrifice in selected_atoms)
		selected_atoms -= sacrifice //Hugbox. Prevents the sacrifice targets from being gibbed.
		//We do this because most other heretic paths let you get away with sacrificing non-player mobs.
		sacrifice.death(FALSE)

	return ..()