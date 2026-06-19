#define ANNOUNCE_CHANCE 20
#define REMOVE_RANDOM_LAW_CHANCE 60

/datum/objective/heretic_wildcard/ai_law
	name = "enlighten ai"
	explanation_text = "Perform the Enlighten Machine ritual in the AI upload. You will have to defend yourself for 60 seconds."
	finish_text = "The Blacksmith smiles upon you, and upon the newly enlightened machines. He rewards you, and you feel your mind expanding..."
	max_progress = 1
	knowledge_per_progress = 2
	knowledge_to_gain = list(/datum/heretic_knowledge/ai_law_ritual)

/datum/heretic_knowledge/ai_law_ritual
	name = "Enlighten Machine"
	desc = "Allows you to bring the Light to the station's silicons, by performing this ritual in the AI upload and remaining in the area for 60 seconds."
	unreachable = TRUE
	required_atoms = list()
	research_tree_icon_path = 'icons/mob/silicon/ai.dmi'
	research_tree_icon_state = "ai-core"

/datum/heretic_knowledge/ai_law_ritual/can_be_invoked(datum/antagonist/heretic/invoker)
	return invoker?.wildcard_obj?.is_finished() == FALSE

/datum/heretic_knowledge/ai_law_ritual/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/area/our_area = get_area(loc)
	if (!istype(our_area, /area/station/ai/upload))
		to_chat(user, span_warning("Must be invoked in AI upload!"))
		return FALSE
	return TRUE

/datum/heretic_knowledge/ai_law_ritual/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()

	to_chat(user, span_warning("You have begun the ritual. Remain in the AI upload for one minute and it will be complete."))
	if (!do_after(user, 60 SECONDS, loc, IGNORE_HELD_ITEM|IGNORE_USER_LOC_CHANGE, extra_checks = CALLBACK(src, PROC_REF(check_proximity), user)))
		to_chat(user, span_boldwarning("Failure! The machines remain unenlightened."))
		return FALSE

	var/area/our_area = get_area(loc)
	if (prob(ANNOUNCE_CHANCE))
		priority_announce(
			"WARNING: Unknown thaumaturgical event detected in [our_area.name].",
			"CentCom Thaumatergy Monitor",
			ANNOUNCER_ANOMALIES
		)

	for (var/mob/living/silicon/ai/iter_ai in GLOB.alive_mob_list)
		iter_ai.laws_sanity_check()

		if (prob(REMOVE_RANDOM_LAW_CHANCE))
			iter_ai.remove_law(rand(1, iter_ai.laws.get_law_amount(list(LAW_INHERENT, LAW_SUPPLIED))))

		var/laws_left = 3
		while (laws_left-- > 0)
			iter_ai.add_ion_law(generate_ion_law())

		log_silicon("[key_name(user)], via [src.name], changed laws of [key_name(iter_ai)] to [english_list(iter_ai.laws.get_law_list(TRUE, TRUE))]")

	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	our_heretic?.wildcard_obj?.increment_progress(our_heretic)

/datum/heretic_knowledge/ai_law_ritual/proc/check_proximity(mob/living/user)
	var/area/our_area = get_area(user.loc)
	if (!istype(our_area, /area/station/ai/upload))
		return FALSE
	return TRUE

#undef ANNOUNCE_CHANCE
#undef REMOVE_RANDOM_LAW_CHANCE
