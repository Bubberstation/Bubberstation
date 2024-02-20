/datum/storyteller/predictable
	name = "The Predictable Chaos"
	desc = "The Predictable Chaos will attempt to spawn a lot of antagonists relative to the crew population, while also ensuring events roll every set amount of time. Expect minor events every 10 minutes, moderate events every 30 minutes, and major events every hour and a half."
	welcome_text = "A predictable failure, Dr. Freeman."
	population_min = 35

	var/crew_per_antag = 9 //Basically this means for every 9 crew, spawn 1 antag.
	//9 crew: 1 antagonist
	//18 crew: 2 antagonists
	//27 crew: 3 antagonists
	//36 crew: 4 antagonists
	//45 crew: 5 antagonists
	//54 crew: 6 antagonists
	//63 crew: 7 antagonists
	//72 crew: 8 antagonists
	//81 crew: 9 antagonists
	//90 crew: 10 antagonists
	//REMEMBER: This is CREW pop, NOT server pop

	tag_multipliers = list(

		TAG_COMBAT = 0.25, //Already got this from the constant antag spawns.
		TAG_POSITIVE = 1.25, //Increase this even more if there is too much chaos in events. This is basically how you balance this storyteller.

		TAG_TARGETED = 0.25, //Let us not waste event rolls on single people every 5 or so minutes.

		TAG_OUTSIDER_ANTAG = 0.25, //BurgerBB was here.

	)

	event_repetition_multiplier = 0.25 //Repeat events are boring.

	var/mundane_event_delay = 10 MINUTES
	var/moderate_event_delay = 30 MINUTES
	var/major_event_delay = 90 MINUTES

	COOLDOWN_DECLARE(mundane_event_cooldown)
	COOLDOWN_DECLARE(moderate_event_cooldown)
	COOLDOWN_DECLARE(major_event_cooldown)


/datum/storyteller/predictable/New(...)
	reset_cooldowns()
	. = ..()

/datum/storyteller/predictable/proc/reset_cooldowns()
	COOLDOWN_START(src, mundane_event_cooldown, mundane_event_delay)
	COOLDOWN_START(src, moderate_event_cooldown, moderate_event_cooldown)
	COOLDOWN_START(src, major_event_cooldown, major_event_cooldown)

/datum/storyteller/predictable/proc/should_spawn_antagonists(do_debug=FALSE)

	var/total_crew_score = 0
	var/total_antagonist_score = 0

	for(var/datum/mind/mob_mind as anything in SSticker.minds)

		if(!mob_mind.active || !mob_mind.key)
			continue //Nope

		var/antagonist_score = 0
		for(var/datum/antagonist/antag as anything in mob_mind.antag_datums)
			if( !antag.show_in_antagpanel || (antag.antag_flags & FLAG_FAKE_ANTAG)) //For unimportant antags, like ashwalkers or valentines. You're not a real antag.
				continue
			antagonist_score += antagonist_score/max(1,1 + antagonist_score) //This means if you're a double antag (changeling + traitor, for example) you could extra, but not as much.
			//We add to the total antagonist score later.

		if(mob_mind.assigned_role)
			var/datum/job/current_job = mob_mind.assigned_role
			if(current_job.faction == FACTION_STATION) //This means you're actually crew.
				var/crew_score = 1 //You count as 1.
				if(current_job.auto_deadmin_role_flags & DEADMIN_POSITION_SECURITY) //Doubled if you're security.
					crew_score *= 2
				if(current_job.auto_deadmin_role_flags & DEADMIN_POSITION_HEAD) //Doubled if you're a head.
					crew_score *= 2
				if(antagonist_score > 0) //If you're an antagonist as an important role, then holy fuck.
					antagonist_score *= 3
				else
					if(mob_mind.current && mob_mind.current.stat == DEAD)
						crew_score *= -0.25 //If you're dead, then usually some chaos must be happening and you in fact are a burden towards the crew.
					total_crew_score += round(crew_score,0.25)

		if(antagonist_score)
			total_antagonist_score += round(antagonist_score,0.25)

	total_crew_score *= (1/crew_per_antag) // Remember that security count double, as well as heads.


	if(do_debug)
		debug_world("Attempted to spawn antagonists. Crew score: [total_crew_score], Antagonist Score: [total_antagonist_score], Result: [total_antagonist_score < total_crew_score ? "Spawn antagonists." : "Do not spawn antagonists."]")

	return total_antagonist_score < total_crew_score


/datum/storyteller/predictable/handle_tracks()

	. = FALSE

	if(SSshuttle.emergency.mode == SHUTTLE_IDLE) //Only do serious shit if the emergency shuttle is at Central Command and not in transit.

		if(should_spawn_antagonists() && find_and_buy_event_from_track(EVENT_TRACK_ROLESET))
			. = TRUE

		if(COOLDOWN_FINISHED(src,major_event_cooldown) && find_and_buy_event_from_track(EVENT_TRACK_MAJOR))
			COOLDOWN_START(src, major_event_cooldown, major_event_delay)
			return TRUE

	if(COOLDOWN_FINISHED(src,moderate_event_cooldown) && find_and_buy_event_from_track(EVENT_TRACK_MODERATE))
		COOLDOWN_START(src, moderate_event_cooldown, moderate_event_delay)
		return TRUE

	if(COOLDOWN_FINISHED(src,mundane_event_cooldown) && find_and_buy_event_from_track(EVENT_TRACK_MUNDANE))
		COOLDOWN_START(src, mundane_event_cooldown, mundane_event_delay)
		return TRUE
