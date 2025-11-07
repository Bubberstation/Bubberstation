/datum/round_event_control/execute_psychic_drone
	id = "psychic_drone"
	name = "Execute the Psychic Drone"
	description = "Deploy a psychic drone to broadcast disruptive psionic noise across the station."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_MIND
	typepath = /datum/round_event/psychic_drone

	min_players = 5
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED

/datum/round_event/psychic_drone
	// Default, but randomize per wave or target
	var/target_sex = MALE
	// Assume custom drone mob (implement separately)
	var/drone_path = /mob/living/basic/psychic_drone
	// Time between noise pulses
	var/wave_duration = 30 SECONDS
	// Total pulses, scaled by threat
	var/num_waves = 5
	// 1=low (mild effects), 5=high (intense hallucinations/vomiting)
	var/noise_strength = 1
	// % chance for positive vs negative noise
	var/positive_noise_chance = 50

	start_when = 30

/datum/round_event/psychic_drone/__setup_for_storyteller(threat_points)
	. = ..()

	if(threat_points < STORY_THREAT_LOW)
		noise_strength = 1
		num_waves = 3
		positive_noise_chance = 60  // More positive early to build false security
	else if(threat_points < STORY_THREAT_MODERATE)
		noise_strength = 2
		num_waves = 5
		positive_noise_chance = 50
	else if(threat_points < STORY_THREAT_HIGH)
		noise_strength = 3
		num_waves = 7
		positive_noise_chance = 30
	else if(threat_points < STORY_THREAT_EXTREME)
		noise_strength = 4
		num_waves = 10
		positive_noise_chance = 20
	else
		noise_strength = 5
		num_waves = 15
		positive_noise_chance = 10

	// Dynamic scaling
	num_waves = min(round(num_waves + round(threat_points / 400)), 5)


/datum/round_event/psychic_drone/__start_for_storyteller()
	var/turf/spawn_turf = get_safe_random_station_turf()
	var/obj/structure/closet/supplypod/pod = podspawn(list(
		"target" = spawn_turf,
		"path" = /obj/structure/closet/supplypod/podspawn/no_return,
		"style" = /datum/pod_style/deathsquad,
		"spawn" = drone_path,
	))
	var/mob/living/basic/psychic_drone/drone = locate() in pod.contents
	drone.noise_strength = noise_strength
	drone.positive_noise_chance = positive_noise_chance
	drone.num_waves = num_waves
	drone.wave_duration = wave_duration
	drone.target_sex = pick(MALE, FEMALE) // There only two genders in the universe, deal with it

	notify_ghosts("Psychic drone deployed at [get_area(spawn_turf)].", spawn_turf, "Phychic drone deployed")
	priority_announce("A psychic drone has been deployed at [get_area(spawn_turf)], broadcasting disruptive psionic noise across the station! It's option set to [drone.target_sex].", "Anomalies detected")


/mob/living/basic/psychic_drone
	name = "psychic drone"
	desc = "A hovering orb emitting faint psionic waves, influencing crew minds in unpredictable ways."
	icon = 'icons/mob/simple/hivebot.dmi'
	icon_state = "commdish"
	density = TRUE
	health = 2000
	maxHealth = 2000
	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	basic_mob_flags = IMMUNE_TO_FISTS
	speed = 0
	faction = list(FACTION_HOSTILE)
	status_flags = 0
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG

	var/positive_noise_chance
	var/noise_strength = 1
	var/num_waves = 5
	var/wave_duration = 30 SECONDS
	var/current_wave = 0
	var/is_bad = TRUE
	var/target_sex = MALE // The power of man

/mob/living/basic/psychic_drone/Initialize(mapload, threat_mod = 1.0, tension_mod = 1.0)
	. = ..()
	noise_strength *= threat_mod
	num_waves = round(num_waves * tension_mod)
	addtimer(CALLBACK(src, PROC_REF(pulse_psychic_noise)), wave_duration)
	if(prob(positive_noise_chance))
		is_bad = FALSE

/mob/living/basic/psychic_drone/Destroy()
	return ..()

/mob/living/basic/psychic_drone/proc/pulse_psychic_noise()
	current_wave++
	if(current_wave > num_waves)
		qdel(src)
		return
	var/list/targets = list()
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind || H.stat == DEAD || !is_station_level(H.z))
			continue
		targets += H

	if(length(targets))
		var/target_sex_local = pick(MALE, FEMALE)
		for(var/mob/living/carbon/human/target in targets)
			apply_psychic_noise(target, is_bad, noise_strength, target_sex_local)

	if(prob(25 * current_wave))
		noise_strength += 1

	addtimer(CALLBACK(src, PROC_REF(pulse_psychic_noise)), wave_duration)

/mob/living/basic/psychic_drone/proc/apply_psychic_noise(mob/living/carbon/human/target, is_positive, strength, target_sex)
	var/debuff_duration = 30 SECONDS * strength

	var/effect_msg = ""
	if(is_positive)
		if(target_sex == MALE)
			effect_msg = span_notice("A confident surge fills your mind, sharpening your focus.")
		else if(target_sex == FEMALE)
			effect_msg = span_notice("Empathic waves soothe your thoughts, easing tensions.")
		else
			effect_msg = span_notice("A neutral hum clears mental fog briefly.")

		if(target.gender == target_sex || target.gender == PLURAL || target.gender == NEUTER)
			target.add_mood_event("psychic_drone", /datum/mood_event/psychic_drone_positive)
			target.add_movespeed_modifier(/datum/movespeed_modifier/psychic_boost, update=TRUE)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, remove_movespeed_modifier), /datum/movespeed_modifier/psychic_boost, TRUE), debuff_duration)
	else if(is_positive == FALSE)
		if(target_sex == MALE)
			effect_msg = span_userdanger("Aggressive shrieks invade your head, fueling rage!")
		else if(target_sex == FEMALE)
			effect_msg = span_userdanger("Hysterical cries overwhelm you, shattering composure!")
		else
			effect_msg = span_userdanger("Disorienting wails echo, inducing nausea.")
			target.adjust_disgust(25 * strength)

		if(target.gender == target_sex || target.gender == PLURAL || target.gender == NEUTER)
			SEND_SOUND(target, sound('sound/items/weapons/flash_ring.ogg'))
			if(strength <= 2)
				target.add_mood_event("psychic_drone", /datum/mood_event/psychic_drone_negative)
			else if(strength <= 4)
				target.add_mood_event("psychic_drone", /datum/mood_event/psychic_drone_negative/strong)
			else if(strength <= 5)
				target.add_mood_event("psychic_drone", /datum/mood_event/psychic_drone_negative/extreme)
			target.adjustOxyLoss(rand(30-40), forced=TRUE)
			target.adjust_hallucinations(30 SECONDS)
			target.adjust_drunk_effect(30)
	else
		effect_msg = span_notice("A subtle psychic hum resonates, leaving you mildly disoriented but aware.")
		target.adjust_disgust(10 * strength)

	to_chat(target, effect_msg)
	new /obj/effect/temp_visual/psychic_scream(get_turf(target), target)

/datum/mood_event/psychic_drone_negative
	description = "Psionic echoes unsettle my thoughts."
	mood_change = -16
	timeout = 30 SECONDS

/datum/mood_event/psychic_drone_negative/strong
	description = "Intense psychic noise disrupts my focus severely."
	mood_change = -24
	timeout = 30 SECONDS

/datum/mood_event/psychic_drone_negative/extreme
	description = "Overwhelming psionic waves crush my mental stability."
	mood_change = -40
	timeout = 30 SECONDS

/datum/mood_event/psychic_drone_positive
	description = "A psionic surge invigorates my mind."
	mood_change = 14
	timeout = 30 SECONDS

/datum/movespeed_modifier/psychic_boost
	multiplicative_slowdown = -0.5

/obj/effect/temp_visual/psychic_scream
	name = "psychic scream"
	icon = 'icons/effects/effects.dmi'
	icon_state = "cursehand0"
	duration = 10
	layer = ABOVE_MOB_LAYER
