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

/datum/storyteller_goal/epidemic_outbreak
	id = "epidemic_outbreak"
	name = "Epidemic Outbreak"
	desc = "Initiate a viral infection across the station, escalating in severity and spread based on current threat levels. \
			At peak threats, multiple strains may emerge simultaneously, accelerating chaos toward global objectives \
			like evacuation or containment failure."
	category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_WIDE_IMPACT

	requierd_population = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED


/datum/storyteller_goal/epidemic_outbreak/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if( !.)
		return FALSE
	return vault[STORY_VAULT_CREW_DISEASES] <= STORY_VAULT_MINOR_DISEASES

/datum/storyteller_goal/epidemic_outbreak/get_progress(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/infected_count = 0
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(length(H.diseases))
			infected_count++
	var/target_infected = round(GLOB.player_list.len * 0.3)
	return clamp(infected_count / max(1, target_infected), 0, 1)

/datum/storyteller_goal/epidemic_outbreak/can_fire_now(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return is_available(vault, inputs, storyteller)

/datum/storyteller_goal/epidemic_outbreak/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	var/normalized_threat = threat_points / storyteller.max_threat_scale
	var/severity = round(lerp(ADV_DISEASE_MEDIUM, ADV_DISEASE_DANGEROUS, normalized_threat))
	var/num_diseases = (normalized_threat > 0.8) ? rand(2, 3) : 1
	var/initial_carriers = round(lerp(1, 5, normalized_threat))
	var/transmissibility = lerp(ADV_SPREAD_FORCED_LOW, ADV_SPREAD_FORCED_HIGH, normalized_threat)

	for(var/i = 1 to num_diseases)
		var/datum/round_event_control/disease_outbreak/advanced/control = new /datum/round_event_control/disease_outbreak/advanced()
		var/datum/round_event/disease_outbreak/advanced/E = new /datum/round_event/disease_outbreak/advanced()
		E.requested_severity = severity
		E.requested_transmissibility = transmissibility
		E.max_symptoms = round(lerp(ADV_MIN_SYMPTOMS, ADV_MAX_SYMPTOMS + 1, normalized_threat))

		control.generate_candidates()
		var/list/afflicted = control.disease_candidates.Copy(1, initial_carriers + 1)
		var/datum/disease/advance/random/new_disease = new /datum/disease/advance/random(E.max_symptoms, severity)
		for(var/mob/living/carbon/human/victim in afflicted)
			victim.ForceContractDisease(new_disease, FALSE)
			notify_ghosts(
				"[victim] was infected with [new_disease.name]!",
				source = victim,
			)


		E.__setup_for_storyteller(threat_points)
		E.announce_when = ADV_ANNOUNCE_DELAY * (1 + normalized_threat * 0.5)
		E.start()

	priority_announce("Detected anomalous viral signatures. Containment protocols advised.", "Biohazard Alert", ANNOUNCER_OUTBREAK7)


	if(normalized_threat > 0.7)
		path_ids += list("quarantine_breach", "virus_mutation")
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
