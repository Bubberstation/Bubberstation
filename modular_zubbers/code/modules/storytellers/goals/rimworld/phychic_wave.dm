/datum/round_event_control/psychic_wave
	id = "psychic_wave"
	name = "Psychic Wave"
	description = "Unleash a powerful psychic wave that disrupts the minds of the crew, causing hallucinations and mental distress."
	story_category = STORY_GOAL_BAD | STORY_GOAL_MAJOR
	tags = STORY_TAG_AFFECTS_CREW_MIND | STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_WHOLE_STATION
	typepath = /datum/round_event/storyteller_psychic_wave

	min_players = 4
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	map_flags = EVENT_SPACE_ONLY


/datum/round_event/storyteller_psychic_wave
	STORYTELLER_EVENT

	var/vomit_chance = 20

	var/psychic_wave_update_interval = 15 SECONDS
	var/mood_debuff_duration = 10 MINUTES
	var/mood_debuff_amount = -10

	var/hallucination_cooldown = 40 SECONDS
	var/hallucination_duration = 3 MINUTES

	var/brain_damage_chance = 10
	var/brain_damage_cooldown_time = 20 SECONDS

	var/can_give_quick = TRUE
	var/mental_damage = TRUE
	var/safe_distance_from_space = 40

	var/message_low = "You feel a slight unease wash over you."
	var/message_high = "A powerful psychic wave crashes through your mind, distorting your perception of reality!"
	var/message_extreme = "Your mind is overwhelmed by an intense psychic assault, leaving you disoriented and vulnerable!"
	var/message_extreme_brain = "The psychic wave has severely damaged your brain, leaving lasting effects!"

	COOLDOWN_DECLARE(hallucination_wave_cooldown)
	COOLDOWN_DECLARE(brain_damage_cooldown)
	COOLDOWN_DECLARE(psychic_wave_cooldown)


/datum/round_event/storyteller_psychic_wave/__setup_for_storyteller(threat_points, ...)
	. = ..()
	var/bonus_time = 0
	if(threat_points < STORY_THREAT_MODERATE)
		vomit_chance = 15
		mood_debuff_duration = 5 MINUTES
		mood_debuff_amount = -20
		hallucination_duration = 2 MINUTES
		brain_damage_chance = 5
		message_low = "You sense a faint presence lingering at the edge of your thoughts."
		message_high = "A subtle psychic whisper brushes against your mind, stirring unease."
		message_extreme = "An elusive entity grazes your consciousness, leaving you slightly off-balance."
		message_extreme_brain = "The fleeting psychic touch has left a minor scar on your neural pathways."
	else if(threat_points < STORY_THREAT_HIGH)
		vomit_chance = 20
		mood_debuff_duration = 10 MINUTES
		mood_debuff_amount = -30
		hallucination_duration = 3 MINUTES
		brain_damage_chance = 10
		message_low = "You feel an unseen observer watching from the shadows of your mind."
		message_high = "A persistent psychic presence invades your thoughts, warping your senses."
		message_extreme = "The entity presses harder, twisting your perception and sowing confusion."
		message_extreme_brain = "The intruding force has inflicted noticeable harm to your brain's structure."
		bonus_time = 120
	else if(threat_points < STORY_THREAT_EXTREME)
		vomit_chance = 25
		mood_debuff_duration = 12 MINUTES
		mood_debuff_amount = -60
		hallucination_duration = 4 MINUTES
		brain_damage_chance = 15
		message_low = "A chilling awareness dawns—you are not alone in your own head."
		message_high = "The psychic intruder claws at your mind, fracturing your grip on reality."
		message_extreme = "The presence surges forward, assaulting your psyche with overwhelming force."
		message_extreme_brain = "The entity's attack has ravaged your brain, causing deep and persistent damage."
	else
		vomit_chance = 40
		mood_debuff_duration = 15 MINUTES
		mood_debuff_amount = -80
		hallucination_duration = 5 MINUTES
		brain_damage_chance = 20
		message_low = "An ominous entity stirs within, threatening to consume your sanity."
		message_high = "The psychic being tears into your consciousness, shattering illusions of safety."
		message_extreme = "Your mind is rent asunder by the intruder's merciless onslaught."
		message_extreme_brain = "The force has brutally shredded your neural tissue, risking total collapse."
		bonus_time = 240

	start_when = rand(30, 60)
	end_when = start_when + rand(450, 800) + bonus_time

/datum/round_event/storyteller_psychic_wave/__announce_for_storyteller()
	priority_announce("Sensors detect a surge of psychic energy enveloping the station. \
					Crew members may experience mental disturbances, including mood shifts, \
					hallucinations, nausea, and potential brain damage. \
					Effects intensify the closer one is to space and double if directly on them.", "Psychic Wave")


/datum/round_event/storyteller_psychic_wave/__start_for_storyteller()
	// First give some time before the first wave hits for precautions
	COOLDOWN_START(src, psychic_wave_cooldown, psychic_wave_update_interval + psychic_wave_update_interval)
	COOLDOWN_START(src, hallucination_wave_cooldown, hallucination_cooldown + psychic_wave_update_interval)
	COOLDOWN_START(src, brain_damage_cooldown, brain_damage_cooldown_time + psychic_wave_update_interval)
	change_space_color("#9932CC", fade_in = TRUE)

/datum/round_event/storyteller_psychic_wave/__storyteller_tick(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, psychic_wave_cooldown))
		update_physic_wave_effects()
		return

	if(COOLDOWN_FINISHED(src, hallucination_wave_cooldown))
		apply_psychic_hallucination_wave()
		COOLDOWN_START(src, hallucination_wave_cooldown, hallucination_cooldown)

	if(COOLDOWN_FINISHED(src, brain_damage_cooldown))
		apply_psychic_brain_damage_wave()
		COOLDOWN_START(src, brain_damage_cooldown, brain_damage_cooldown)

/datum/round_event/storyteller_psychic_wave/__end_for_storyteller()
	. = ..()
	priority_announce("The psychic wave subsides, and the crew's minds begin to clear.")
	change_space_color(fade_in = TRUE)

/datum/round_event/storyteller_psychic_wave/proc/update_physic_wave_effects()
	var/list/crew = get_alive_station_crew(ignore_erp = FALSE, only_crew = FALSE)
	for(var/mob/living/carbon/human/human in crew)
		if(mental_damage && !human.mind)
			continue
		var/turf/T = get_turf(human)
		if(!T)
			continue


		var/in_space = isspaceturf(T)
		var/near_space = FALSE
		for(var/turf/V in view(7, human))
			if(isspaceturf(V))
				near_space = TRUE
				break

		var/multiplier = in_space ? 2 : (near_space ? 1.5 : 0.5)
		human.add_mood_event("psychic_wave", /datum/mood_event/psychic_wave, mood_debuff_amount * multiplier, mood_debuff_duration * multiplier)
		if(in_space || near_space)
			human.overlay_fullscreen("psychic_wave", /atom/movable/screen/fullscreen/phychic_wave)
			addtimer(CALLBACK(human, TYPE_PROC_REF(/mob/living/carbon/human, clear_fullscreen), "psychic_wave"), 10 SECONDS)
			human.set_eye_blur_if_lower((5 SECONDS) * multiplier)
			SEND_SOUND(human, sound('sound/items/weapons/flash_ring.ogg',0,1,0,250))


/datum/round_event/storyteller_psychic_wave/proc/apply_psychic_hallucination_wave()
	var/list/crew = get_alive_station_crew(ignore_erp = FALSE, only_crew = FALSE)
	for(var/mob/living/carbon/human/human in crew)
		if(mental_damage && !human.mind)
			continue
		var/turf/T = get_turf(human)
		if(!T)
			continue

		var/in_space = isspaceturf(T)
		var/near_space = FALSE
		for(var/turf/V in view(7, human))
			if(isspaceturf(V))
				near_space = TRUE
				break

		var/multiplier = in_space ? 2 : (near_space ? 1.5 : 1)

		// Select message based on intensity
		var/msg
		if(multiplier < 1.33)
			msg = message_low
		else if(multiplier < 1.67)
			msg = message_high
		else
			msg = message_extreme
		to_chat(human, span_warning(msg))

		// Apply mood debuff
		human.add_mood_event("psychic_wave", /datum/mood_event/psychic_wave, mood_debuff_amount * multiplier, mood_debuff_duration * multiplier)

		// Vomit chance
		if(prob(vomit_chance * multiplier))
			human.vomit()

		// Hallucination and vision distortion
		human.adjust_hallucinations(hallucination_duration * multiplier)

		// Extended hallucinations and vision changes for near space or in space
		if(near_space || in_space)
			human.adjust_hallucinations(hallucination_duration * multiplier * 0.5) // Extra hallucinations
			if(prob(40 * multiplier))
				human.emote("scream") // Random scream from intense hallucinations
			human.set_dizzy_if_lower(20 SECONDS)
			if(in_space)
				human.set_eye_blur_if_lower(5 SECONDS *	 multiplier)


/datum/round_event/storyteller_psychic_wave/proc/apply_psychic_brain_damage_wave()
	var/list/crew = get_alive_station_crew(ignore_erp = FALSE, only_crew = FALSE)
	for(var/mob/living/carbon/human/human in crew)
		if(mental_damage && !human.mind)
			continue
		var/turf/T = get_turf(human)
		if(!T)
			continue

		var/in_space = isspaceturf(human)
		var/near_space = FALSE
		for(var/turf/V in view(7, human))
			if(isspaceturf(V))
				near_space = TRUE
				break

		var/multiplier = in_space ? 2 : (near_space ? 1.5 : 1)

		// Brain damage chance
		if(prob(brain_damage_chance * multiplier))
			var/obj/item/organ/brain/brain = human.get_organ_by_type(/obj/item/organ/brain)
			if(brain)
				brain.apply_organ_damage(rand(5, 10) * multiplier)
			to_chat(human, span_danger(message_extreme_brain))
			if(in_space)
				human.set_eye_blur_if_lower(10 SECONDS * multiplier)
				if(prob(50))
					brain.gain_trauma_type()


/datum/mood_event/psychic_wave
	description = "A psychic disturbance clouds your thoughts."
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/psychic_wave/add_effects(mood_amount, mood_duration)
	mood_change = mood_amount
	timeout = mood_duration
	update_description()

/datum/mood_event/psychic_wave/proc/update_description()
	if(mood_change >= -20)
		description = "A faint psychic haze lingers in your mind, slightly unsettling."
	else if(mood_change >= -40)
		description = "Psychic interference disrupts your thoughts, causing moderate discomfort."
	else if(mood_change >= -60)
		description = "Intense psychic waves batter your psyche, leading to significant distress."
	else
		description = "Overwhelming psychic assault threatens to shatter your sanity."

/datum/mood_event/psychic_wave/be_refreshed(datum/mood/home, mood_amount, mood_duration)
	if(mood_amount < mood_change)
		mood_change = mood_amount
	if(mood_duration > timeout)
		timeout = mood_duration
	update_description()
	if(timeout)
		addtimer(CALLBACK(home, TYPE_PROC_REF(/datum/mood, clear_mood_event), category), timeout, (TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_NO_HASH_WAIT))
	return BLOCK_NEW_MOOD

/datum/mood_event/psychic_wave/be_replaced(datum/mood/home, datum/mood_event/new_event, ...)
	var/new_amount = new_event.mood_change
	if(new_amount < mood_change)
		return ALLOW_NEW_MOOD
	return BLOCK_NEW_MOOD

/atom/movable/screen/fullscreen/phychic_wave
	icon_state = "supermatter_cascade"
