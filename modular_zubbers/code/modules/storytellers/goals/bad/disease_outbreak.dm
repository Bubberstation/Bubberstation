/// Advanced virus lower limit for symptoms
#define ADV_MIN_SYMPTOMS 3
/// Advanced virus upper limit for symptoms
#define ADV_MAX_SYMPTOMS 4
/// How long the virus stays hidden before announcement
#define ADV_ANNOUNCE_DELAY 75
/// Numerical define for medium severity advanced virus
#define ADV_DISEASE_MEDIUM 1
/// Numerical define for harmful severity advanced virus
#define ADV_DISEASE_HARMFUL 3
/// Numerical define for dangerous severity advanced virus
#define ADV_DISEASE_DANGEROUS 5
/// Percentile for low severity advanced virus
#define ADV_RNG_LOW 40
/// Percentile for mid severity advanced virus
#define ADV_RNG_MID 85
/// Percentile for high vs. low transmissibility
#define ADV_SPREAD_THRESHOLD 85
/// Admin custom low spread
#define ADV_SPREAD_FORCED_LOW 0
/// Admin custom med spread
#define ADV_SPREAD_FORCED_MID 70
/// Admin custom high spread
#define ADV_SPREAD_FORCED_HIGH 90

/datum/round_event_control/disease_outbreak
	id = "epidemic_outbreak"
	name = "Epidemic Outbreak"
	description = "Initiate a viral infection across the station, escalating in severity and spread based on current threat levels. \
			At peak threats, multiple strains may emerge simultaneously, accelerating chaos toward global objectives \
			like evacuation or containment failure."
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_ESCALATION, STORY_TAG_REQUIRES_MEDICAL, STORY_TAG_HEALTH, STORY_TAG_TRAGIC)

	min_players = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED


/datum/round_event_control/disease_outbreak/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if( !.)
		return FALSE
	return inputs.get_entry(STORY_VAULT_CREW_DISEASES) <= STORY_VAULT_MINOR_DISEASES

/datum/round_event_control/disease_outbreak/can_fire_now(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return is_avaible(inputs, storyteller)


/datum/round_event_control/disease_outbreak/run_event_as_storyteller(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	var/normalized_threat = threat_points / storyteller.max_threat_scale
	var/severity = round(lerp(ADV_DISEASE_MEDIUM, ADV_DISEASE_DANGEROUS, normalized_threat))
	var/num_diseases = (normalized_threat > 0.8) ? rand(2, 3) : 1
	var/initial_carriers = round(lerp(1, 5, normalized_threat))
	var/transmissibility = lerp(ADV_SPREAD_FORCED_LOW, ADV_SPREAD_FORCED_HIGH, normalized_threat)

	// Generate candidates for disease infection
	if(!disease_candidates || !length(disease_candidates))
		disease_candidates = list()
		for(var/mob/living/carbon/human/person as anything in get_alive_station_crew(TRUE, TRUE, TRUE))
			var/turf/person_location = get_turf(person)
			if(!person_location || !is_station_level(person_location.z))
				continue
			if(person.stat == DEAD)
				continue
			disease_candidates += person

	for(var/i = 1 to num_diseases)
		var/datum/round_event/disease_outbreak/advanced/evt = new /datum/round_event/disease_outbreak/advanced(src)
		evt.requested_severity = severity
		evt.requested_transmissibility = transmissibility
		evt.max_symptoms = round(lerp(ADV_MIN_SYMPTOMS, ADV_MAX_SYMPTOMS + 1, normalized_threat))

		var/list/afflicted = list()
		for(var/j = 1 to min(initial_carriers, length(disease_candidates)))
			afflicted += pick_n_take(disease_candidates)

		var/datum/disease/advance/event/new_disease = new /datum/disease/advance/event(evt.max_symptoms, severity, transmissibility)
		for(var/mob/living/carbon/human/victim in afflicted)
			victim.ForceContractDisease(new_disease, FALSE)
			notify_ghosts(
				"[victim] was infected with [new_disease.name]!",
				source = victim,
			)

		evt.__setup_for_storyteller(threat_points)
		evt.announce_when = ADV_ANNOUNCE_DELAY * (1 + normalized_threat * 0.5)
		evt.start()
	priority_announce("Detected anomalous viral signatures. Containment protocols advised.", "Biohazard Alert", ANNOUNCER_OUTBREAK7)
	occurrences += 1
	return TRUE



#undef ADV_MIN_SYMPTOMS
#undef ADV_MAX_SYMPTOMS
#undef ADV_ANNOUNCE_DELAY
#undef ADV_DISEASE_MEDIUM
#undef ADV_DISEASE_HARMFUL
#undef ADV_DISEASE_DANGEROUS
#undef ADV_RNG_LOW
#undef ADV_RNG_MID
#undef ADV_SPREAD_THRESHOLD
#undef ADV_SPREAD_FORCED_LOW
#undef ADV_SPREAD_FORCED_MID
#undef ADV_SPREAD_FORCED_HIGH
