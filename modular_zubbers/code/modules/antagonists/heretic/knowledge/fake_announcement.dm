/proc/get_heretic_announcement_sounds()
	RETURN_TYPE(/list)

	var/list/base = GLOB.announcer_keys.Copy()
	for (var/datum/heretic_knowledge/ultimate/ascension as anything in subtypesof(/datum/heretic_knowledge/ultimate))
		if (ascension::announcement_sound)
			base += ascension::announcement_sound

	return base

/datum/heretic_knowledge/fake_announcement
	name = "Voice of the Mansus"
	desc = "Sacrifice a radio to create a fake announcement. Can only be invoked once before it must be researched again."
	gain_text = "Even in our dreams, and indeed, in our dreams first and fore-most, the thrums of the Mansus claim our attention. \
	Knock, and it will heed."
	required_atoms = list(/obj/item/radio = 1)
	drafting_tier = 1
	drafting_cost = 0.5
	research_tree_icon_path = 'icons/mob/actions/actions_revenant.dmi'
	research_tree_icon_state = "discordant_whisper"

/datum/heretic_knowledge/fake_announcement/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/heretic = GET_HERETIC(user)
	if (isnull(heretic))
		return FALSE
	if (!try_user_announce(user, get_heretic_announcement_sounds()))
		return FALSE

	on_lose()
	heretic.researched_knowledge -= type

	heretic.heretic_shops[HERETIC_KNOWLEDGE_SHOP][type] = make_knowledge_entry(
		type,
		null,
		HERETIC_KNOWLEDGE_SHOP,
		drafting_tier,
		drafting_cost
	)
	heretic.update_data_for_all_viewers()

	qdel(src)
	return TRUE
