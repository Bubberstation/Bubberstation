/**
 * A knowledge subtype lets the heretic summon a monster with the ritual, but capped at a limit. Copied from heretic_knowledge
 */
/datum/heretic_knowledge/limited_amount/summon
	abstract_parent_type = /datum/heretic_knowledge/summon
	/// Typepath of a mob to summon when we finish the recipe.
	var/mob/living/mob_to_summon

/datum/heretic_knowledge/limited_amount/summon/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return summon_ritual_mob_limited(user, loc, mob_to_summon)

/**
 * Creates the ritual mob and grabs a ghost for it
 *
 * * user - the mob doing the summoning
 * * loc - where the summon is happening
 * * mob_to_summon - either a mob instance or a mob typepath
 */
/datum/heretic_knowledge/limited_amount/summon/proc/summon_ritual_mob_limited(mob/living/user, turf/loc, mob/living/mob_to_summon)
	var/mob/living/summoned
	if(isliving(mob_to_summon))
		summoned = mob_to_summon
	else
		summoned = new mob_to_summon(loc)
	summoned.ai_controller?.set_ai_status(AI_STATUS_OFF)
	// Fade in the summon while the ghost poll is ongoing.
	// Also don't let them mess with the summon while waiting
	summoned.alpha = 0
	ADD_TRAIT(summoned, TRAIT_NO_TRANSFORM, REF(src))
	summoned.move_resist = MOVE_FORCE_OVERPOWERING
	animate(summoned, 10 SECONDS, alpha = 155)

 	message_admins("A [summoned.name] is being summoned by [ADMIN_LOOKUPFLW(user)] in [ADMIN_COORDJMP(summoned)].")
	var/mob/chosen_one = SSpolling.poll_ghosts_for_target(check_jobban = ROLE_HERETIC, poll_time = 10 SECONDS, checked_target = summoned, ignore_category = poll_ignore_define, alert_pic = summoned, role_name_text = summoned.name)
	if(isnull(chosen_one))
		loc.balloon_alert(user, "ritual failed, no ghosts!")
		animate(summoned, 0.5 SECONDS, alpha = 0)
		QDEL_IN(summoned, 0.6 SECONDS)
		return FALSE

	// Ok let's make them an interactable mob now, since we got a ghost
	summoned.alpha = 255
	REMOVE_TRAIT(summoned, TRAIT_NO_TRANSFORM, REF(src))
	summoned.move_resist = initial(summoned.move_resist)

 	summoned.ghostize(FALSE)
	summoned.key = chosen_one.key

	user.log_message("created a [summoned.name], controlled by [key_name(chosen_one)].", LOG_GAME)
	message_admins("[ADMIN_LOOKUPFLW(user)] created a [summoned.name], [ADMIN_LOOKUPFLW(summoned)].")

	var/datum/antagonist/heretic_monster/heretic_monster = summoned.mind.add_antag_datum(/datum/antagonist/heretic_monster)
	heretic_monster.set_owner(user.mind)

	var/datum/objective/heretic_summon/summon_objective = locate() in user.mind.get_all_objectives()
	summon_objective?.num_summoned++

	//add them to our created items list so they contribute to the cap
	var/atom/created_thing = summoned
	LAZYADD(created_items, WEAKREF(created_thing))

	return TRUE
