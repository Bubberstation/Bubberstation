/datum/storyteller/predictable
	name = "The Predictable Chaos"
	desc = "The Predictable Chaos will attempt to spawn a lot of antagonists relative to the crew population, while also ensuring events roll every set amount of time. Expect minor events every 10 minutes, moderate events every 30 minutes, and major events every hour and a half."
	welcome_text = "Waiter, more chaos! That's enough. Thank you, waiter."
	population_min = 35

	var/crew_per_antag = 20 //Basically this means for every 10 crew, spawn 1 antag. REMEMBER: This is CREW pop, NOT server pop

	tag_multipliers = list(

		TAG_COMBAT = 0.25, //Already got this from the constant antag spawns.
		TAG_POSITIVE = 1.25, //Increase this even more if there is too much chaos in events. This is basically how you balance this storyteller.

		TAG_TARGETED = 0.25, //Let us not waste event rolls on single people every 5 or so minutes.

		TAG_OUTSIDER_ANTAG = 0.25, //BurgerBB was here.

	)

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 2,
		EVENT_TRACK_MODERATE = 2,
		EVENT_TRACK_MAJOR = 2,
		EVENT_TRACK_CREWSET = 2,
		EVENT_TRACK_GHOSTSET = 2
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 2,
		EVENT_TRACK_MODERATE = 2,
		EVENT_TRACK_MAJOR = 2,
		EVENT_TRACK_CREWSET = 2,
		EVENT_TRACK_GHOSTSET = 2
	)

	event_repetition_multiplier = 0.25 //Repeat events are boring.

	var/last_crew_score = 0
	var/last_antag_score = 0

	var/antag_event_delay = 5 MINUTES
	var/mundane_event_delay = 10 MINUTES
	var/moderate_event_delay = 30 MINUTES
	var/major_event_delay = 90 MINUTES

	COOLDOWN_DECLARE(antag_event_cooldown)
	COOLDOWN_DECLARE(mundane_event_cooldown)
	COOLDOWN_DECLARE(moderate_event_cooldown)
	COOLDOWN_DECLARE(major_event_cooldown)


/datum/storyteller/predictable/New(...)
	reset_cooldowns()
	. = ..()


/datum/storyteller/predictable/proc/reset_cooldowns()
	COOLDOWN_START(src, mundane_event_cooldown, mundane_event_delay)
	COOLDOWN_START(src, moderate_event_cooldown, moderate_event_delay)
	COOLDOWN_START(src, major_event_cooldown, major_event_delay)


//IF YOU EDIT THIS PROC, REMEMBER TO ALSO EDIT THE UNIT TESTS IN unit_tests/zubbers/predictable_storyteller.dm
/proc/storyteller_get_antag_to_crew_ratio(do_debug=FALSE,minds_to_use_override)

	var/total_crew_score = 0
	var/total_antagonist_score = 0

	if(!minds_to_use_override)
		minds_to_use_override = SSticker.minds

	var/medical_count = 0
	var/engineering_count = 0

	for(var/datum/mind/mob_mind as anything in minds_to_use_override)

		if(do_debug)
			if(!mob_mind.current)
				continue
		else
			if(!mob_mind.key || !mob_mind.current)
				continue

		var/antagonist_score = 0
		for(var/datum/antagonist/antag as anything in mob_mind.antag_datums)
			if( !antag.show_in_antagpanel || (antag.antag_flags & FLAG_FAKE_ANTAG)) //For unimportant antags, like ashwalkers or valentines. You're not a real antag.
				continue
			antagonist_score += 1
			//We add to the total antagonist score later.

		if(mob_mind.assigned_role)
			var/datum/job/current_job = mob_mind.assigned_role
			if(current_job.faction == FACTION_STATION) //This means you're actually crew.
				var/crew_score = 1 //You count as 1.
				if(current_job.auto_deadmin_role_flags & DEADMIN_POSITION_SECURITY)
					crew_score *= 2
				if(current_job.auto_deadmin_role_flags & DEADMIN_POSITION_HEAD)
					crew_score *= 1.25
				if(antagonist_score > 0)
					if(crew_score > 1)
						antagonist_score *= crew_score //If you're an antagonist as an important role, then you're going to cause some chaos.
				else
					if(mob_mind.current && mob_mind.current.stat == DEAD)
						crew_score *= -0.25 //If you're dead, then usually some chaos must be happening and you in fact are a slight burden towards the crew.
					total_crew_score += crew_score
					//Hacky nonsense here. Limits based on support roles.
					//MEDICAL
					if(current_job.supervisors == SUPERVISOR_CMO)
						if(current_job.title == JOB_MEDICAL_DOCTOR)
							medical_count += 1
						else
							medical_count += 0.5
					//ENGINEERING
					if(current_job.supervisors == SUPERVISOR_CE)
						if(current_job.title == JOB_STATION_ENGINEER)
							engineering_count += 1
						else
							engineering_count += 0.5

		if(antagonist_score)
			total_antagonist_score += antagonist_score

	if(total_crew_score <= 0)
		return INFINITY //Force infinity.

	total_crew_score = total_crew_score*0.75 + min(total_crew_score*0.25,engineering_count*10) //Up to 25% penalty if there are no engineers.
	total_crew_score = total_crew_score*0.25 + min(total_crew_score*0.75,medical_count*10) //Up to 75% penalty if there are no medical doctors.

	return round(total_antagonist_score/total_crew_score,0.01)


/datum/storyteller/predictable/handle_tracks()

	if(!COOLDOWN_FINISHED(src,antag_event_cooldown)) //Don't want to run an antag event then suddenly have meteors.
		return FALSE

	if(SSshuttle.emergency.mode == SHUTTLE_IDLE) //Only do serious shit if the emergency shuttle is at Central Command and not in transit.
		if(storyteller_get_antag_to_crew_ratio() < (1/crew_per_antag) && find_and_buy_event_from_track(EVENT_TRACK_CREWSET))
			COOLDOWN_START(src,antag_event_cooldown,antag_event_delay)
			return TRUE
		if(COOLDOWN_FINISHED(src,major_event_cooldown) && find_and_buy_event_from_track(EVENT_TRACK_MAJOR))
			COOLDOWN_START(src, major_event_cooldown, major_event_delay)
			COOLDOWN_START(src, moderate_event_cooldown, moderate_event_delay)
			COOLDOWN_START(src, mundane_event_cooldown, mundane_event_delay)
			return TRUE

	if(COOLDOWN_FINISHED(src,moderate_event_cooldown) && find_and_buy_event_from_track(EVENT_TRACK_MODERATE))
		COOLDOWN_START(src, moderate_event_cooldown, moderate_event_delay)
		COOLDOWN_START(src, mundane_event_cooldown, mundane_event_delay)
		return TRUE

	if(COOLDOWN_FINISHED(src,mundane_event_cooldown) && find_and_buy_event_from_track(EVENT_TRACK_MUNDANE))
		COOLDOWN_START(src, mundane_event_cooldown, mundane_event_delay)
		return TRUE

	return FALSE
