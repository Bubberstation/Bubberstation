/datum/controller/subsystem/polling/is_eligible(mob/potential_candidate, role, check_jobban, the_ignore_category)

	. = ..()

	if(!.)
		return .

	if(check_jobban && is_observer(potential_candidate)) //If a role has a jobban flag, it is a very high chance it's important enough to exclude potential fishers.
		var/mob/dead/observer/observing_mob = potential_candidate
		if(observing_mob.started_as_observer) //This doesn't solve the issue 100% but it sure is obvious if someone joins then immediately cryos, much like how people do this if they don't get antag roundstart.
			return FALSE
