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
#define ADV_SPREAD_THRESHOLD 80
/// Admin custom low spread
#define ADV_SPREAD_FORCED_LOW 0
/// Admin custom med spread
#define ADV_SPREAD_FORCED_MID 70
/// Admin custom high spread
#define ADV_SPREAD_FORCED_HIGH 90

/datum/round_event_control/disease_outbreak
	name = "Disease Outbreak: Classic"
	typepath = /datum/round_event/disease_outbreak
	max_occurrences = 1
	min_players = 10
	weight = 5
	category = EVENT_CATEGORY_HEALTH
	description = "A 'classic' virus will infect some members of the crew."
	min_wizard_trigger_potency = 2
	max_wizard_trigger_potency = 6
	admin_setup = list(/datum/event_admin_setup/minimum_candidate_requirement/disease_outbreak, /datum/event_admin_setup/listed_options/disease_outbreak)
	///Disease recipient candidates
	var/list/disease_candidates = list()

/datum/round_event_control/disease_outbreak/can_spawn_event(players_amt, allow_magic = FALSE)
	. = ..()
	if(!.)
		return .
	generate_candidates()
	// BUBBER EDIT CHANGE START - Disease Transmission
	if(!SSjob.is_skeleton_medical(3))
		log_public_file("Disease outbreak check passed medbay staffing parameters with 3 or more staff.")
		if(length(disease_candidates))
			log_public_file("Disease outbreak check passed candidate parameters with [length(disease_candidates)] candidates.")
			return TRUE
		log_public_file("Disease outbreak check failed catastrophically. oh god how did we get here, there are zero candidates? this should never happen.")
	else
		log_public_file("Disease outbreak check failed medbay staffing parameters due to less than 3 staff.")
	// BUBBER EDIT CHANGE END - Disease Transmission

/**
 * Creates a list of people who are elligible to become disease carriers for the event
 *
 * Searches through the player list, adding anyone who is elligible to be a disease carrier for the event. This checks for
 * whether or not the candidate is alive, a crewmember, is able to receive a disease, and whether or not a disease is already present in them.
 * This proc needs to be run at some point to ensure the event has candidates to infect.
 */
/datum/round_event_control/disease_outbreak/proc/generate_candidates()
	disease_candidates.Cut() //We clear the list and rebuild it again.
	for(var/mob/living/carbon/human/candidate in shuffle(GLOB.player_list)) //Player list is much more up to date and requires less checks(?)
		if(!(candidate.mind.assigned_role.job_flags & JOB_CREW_MEMBER) || candidate.stat == DEAD)
			continue
		if(HAS_TRAIT(candidate, TRAIT_VIRUSIMMUNE)) //Don't pick someone who's virus immune, only for it to not do anything.
			continue
		if(length(candidate.diseases)) //Is our candidate already sick?
			continue
		if(!is_station_level(candidate.z) && !is_mining_level(candidate.z)) //Diseases can't really spread if the vector is in deep space.
			continue
		if(candidate.internal || candidate.external || candidate.wear_mask)
			continue
		// SKYRAT EDIT ADDITION START - Station/area event candidate filtering.
		if(engaged_role_play_check(candidate, station = TRUE, dorms = TRUE))
			continue
		if(issynthetic(candidate)) // BUBBER EDIT ADDITION - Disease Transmission
			continue
		// SKYRAT EDIT ADDITION END
		disease_candidates += candidate

///Handles checking and alerting admins about the number of valid candidates
/datum/event_admin_setup/minimum_candidate_requirement/disease_outbreak
	output_text = "There are no candidates eligible to receive a disease!"

/datum/event_admin_setup/minimum_candidate_requirement/disease_outbreak/count_candidates()
	var/datum/round_event_control/disease_outbreak/disease_control = event_control
	disease_control.generate_candidates() //can_spawn_event() is bypassed by admin_setup, so this makes sure that the candidates are still generated
	return length(disease_control.disease_candidates)


///Handles actually selecting whicch disease will spawn.
/datum/event_admin_setup/listed_options/disease_outbreak
	input_text = "Select a specific disease? Warning: Some are EXTREMELY dangerous."
	normal_run_option = "Random Classic Disease (Safe)"
	special_run_option = "Entirely Random Disease (Dangerous)"

/datum/event_admin_setup/listed_options/disease_outbreak/get_list()
	return subtypesof(/datum/disease)

/datum/event_admin_setup/listed_options/disease_outbreak/apply_to_event(datum/round_event/disease_outbreak/event)
	var/datum/disease/virus
	if(chosen == special_run_option)
		virus = pick(get_list())
	else
		virus = chosen
	event.virus_type = virus

/datum/round_event/disease_outbreak
	announce_when = 22
	///The disease type we will be spawning
	var/datum/disease/virus_type
	///The preset (classic) or generated (advanced) illness name
	var/illness_type = ""
	///Disease recipient candidates, passed from the round_event_control object
	var/list/afflicted = list()

/datum/round_event/disease_outbreak/announce(fake)
	for(var/datum/disease/advance/active_carrier in SSdisease.event_diseases)
		active_carrier.make_visible()

	if(!illness_type)
		var/list/virus_candidates = list(
			/datum/disease/anxiety,
			/datum/disease/beesease,
			/datum/disease/brainrot,
			/datum/disease/cold9,
			/datum/disease/flu,
			/datum/disease/fluspanish,
			/datum/disease/magnitis,
			/// And here are some that will never roll for real, just to mess around.
			/datum/disease/death_sandwich_poisoning,
			/datum/disease/dna_retrovirus,
			/datum/disease/gbs,
			/datum/disease/rhumba_beat,
		)
		var/datum/disease/fake_virus = pick(virus_candidates)
		illness_type = initial(fake_virus.name)
	priority_announce("Confirmed outbreak of level 7 viral biohazard aboard [station_name()]. All personnel must contain the outbreak.", "[illness_type] Alert", ANNOUNCER_OUTBREAK7)

/datum/round_event/disease_outbreak/setup()
	announce_when = 22

/datum/round_event/disease_outbreak/start()
	var/datum/round_event_control/disease_outbreak/disease_event = control
	afflicted += disease_event.disease_candidates
	disease_event.disease_candidates.Cut() //Clean the list after use
	if(!virus_type)
		var/list/virus_candidates = list()

		//Practically harmless diseases. Mostly just gives medical something to do.
		virus_candidates += list(/datum/disease/flu, /datum/disease/cold9)

		//The more dangerous ones
		//virus_candidates += list(/datum/disease/beesease, /datum/disease/brainrot, /datum/disease/fluspanish)

		//The wacky ones
		virus_candidates += list(/datum/disease/magnitis, /datum/disease/anxiety, /datum/disease/beesease)

		//The rest of the diseases either aren't conventional "diseases" or are too unique/extreme to be considered for a normal event
		virus_type = pick(virus_candidates)

	var/datum/disease/new_disease
	new_disease = new virus_type()
	//new_disease.carrier = TRUE // BUBBER EDIT REMOVE - Disease Transmission
	illness_type = new_disease.name
	new_disease.event_disease = TRUE // BUBBER EDIT ADDITION - Disease Transmission

	// BUBBER EDIT ADDITION START - Disease Transmission
	var/to_infect = 3
	if(length(GLOB.alive_player_list) > 65)
		to_infect = 4

	var/infected = 0
	// BUBBER EDIT ADDITION END - Disease Transmission

	var/mob/living/carbon/human/victim
	while(length(afflicted) && infected < to_infect) // BUBBER EDIT CHANGE - Disease Transmission
		victim = pick_n_take(afflicted)
		if(victim.ForceContractDisease(new_disease, TRUE, infect_vector = "EVENT", final_infectivity = 100)) // BUBBER EDIT CHANGE - Disease Transmission
			message_admins("Event triggered: Disease Outbreak - [new_disease.name] starting with patient zero [ADMIN_LOOKUPFLW(victim)]!")
			log_game("Event triggered: Disease Outbreak - [new_disease.name] starting with patient zero [key_name(victim)].")
			announce_to_ghosts(victim)
			infected++ // BUBBER EDIT ADDITION - Disease Transmission
			// return // BUBBER EDIT REMOVAL - Disease Transmission
		CHECK_TICK //don't lag the server to death
	if(isnull(victim))
		message_admins("Event Disease Outbreak: Classic attempted to start, but failed to find a candidate target.")
		log_game("Event Disease Outbreak: Classic attempted to start, but failed to find a candidate target")

/datum/round_event_control/disease_outbreak/advanced
	name = "Disease Outbreak: Advanced"
	typepath = /datum/round_event/disease_outbreak/advanced
	category = EVENT_CATEGORY_HEALTH
	weight = 15
	min_players = 35 // To avoid shafting lowpop
	earliest_start = 15 MINUTES // give the chemist a chance
	description = "An 'advanced' disease will infect some members of the crew."
	min_wizard_trigger_potency = 2
	max_wizard_trigger_potency = 6
	admin_setup = list(
		/datum/event_admin_setup/minimum_candidate_requirement/disease_outbreak,
		/datum/event_admin_setup/listed_options/disease_outbreak_advanced/severity,
		/datum/event_admin_setup/input_number/disease_outbreak_advanced,
		/datum/event_admin_setup/listed_options/disease_outbreak_advanced/transmissibility
	)

/**
 * Admin virus customization
 *
 * If the admin wishes, give them the opportunity to select the severity and number of symptoms.
 */

/datum/event_admin_setup/listed_options/disease_outbreak_advanced/severity
	input_text = "Pick a severity!"
	normal_run_option = "Random"

/datum/event_admin_setup/listed_options/disease_outbreak_advanced/severity/get_list()
	return list("Medium", "Harmful", "Dangerous")

/datum/event_admin_setup/listed_options/disease_outbreak_advanced/severity/apply_to_event(datum/round_event/disease_outbreak/advanced/event)
	switch(chosen)
		if("Medium")
			event.requested_severity = ADV_DISEASE_MEDIUM
		if("Harmful")
			event.requested_severity = ADV_DISEASE_HARMFUL
		if("Dangerous")
			event.requested_severity = ADV_DISEASE_DANGEROUS
		if("Random")
			event.requested_severity = null
		else
			return ADMIN_CANCEL_EVENT

/datum/event_admin_setup/listed_options/disease_outbreak_advanced/transmissibility
	input_text = "Pick a transmissibility!"
	normal_run_option = "Random"

/datum/event_admin_setup/listed_options/disease_outbreak_advanced/transmissibility/get_list()
	return list("Blood/Fluids", "Skin Contact", "Airborne")

/datum/event_admin_setup/listed_options/disease_outbreak_advanced/transmissibility/apply_to_event(datum/round_event/disease_outbreak/advanced/event)
	switch(chosen)
		if("Blood/Fluids")
			event.requested_transmissibility = ADV_SPREAD_FORCED_LOW
		if("Skin Contact")
			event.requested_transmissibility = ADV_SPREAD_FORCED_MID
		if("Airborne")
			event.requested_transmissibility = ADV_SPREAD_FORCED_HIGH
		if("Random")
			event.requested_transmissibility = null
		else
			return ADMIN_CANCEL_EVENT

/datum/event_admin_setup/input_number/disease_outbreak_advanced
	input_text = "How many symptoms do you want your virus to have?"
	default_value = 4
	max_value = 7
	min_value = 1

/datum/event_admin_setup/input_number/disease_outbreak_advanced/prompt_admins()
	var/customize_number_of_symptoms = tgui_alert(usr, "Select number of symptoms?", event_control.name, list("Default", "Custom"))
	switch(customize_number_of_symptoms)
		if("Custom")
			return ..()
		if("Default")
			chosen_value = null
		else
			return ADMIN_CANCEL_EVENT

/datum/event_admin_setup/input_number/disease_outbreak_advanced/apply_to_event(datum/round_event/disease_outbreak/advanced/event)
	event.max_symptoms = chosen_value

/datum/round_event/disease_outbreak/advanced
	///Number of symptoms for our virus
	var/requested_severity
	///Transmissibility of our virus
	var/requested_transmissibility
	///Maximum symptoms for our virus
	var/max_symptoms

/**
 * Generate virus base values
 *
 * Generates a virus with either the admin selected parameters for severity and symptoms
 * or if it was not selected, randomly pick between the MIX and MAX configured in the defines.
 */
/datum/round_event/disease_outbreak/advanced/start()
	var/datum/round_event_control/disease_outbreak/advanced/disease_event = control
	afflicted += disease_event.disease_candidates
	disease_event.disease_candidates.Cut()

	if(isnull(max_symptoms))
		max_symptoms = rand(ADV_MIN_SYMPTOMS, ADV_MAX_SYMPTOMS)

	if(isnull(requested_severity))
		var/rng_severity = rand(1, 100)
		if(rng_severity < ADV_RNG_LOW)
			requested_severity = ADV_DISEASE_MEDIUM

		else if(rng_severity < ADV_RNG_MID)
			requested_severity = ADV_DISEASE_HARMFUL

		else
			requested_severity = ADV_DISEASE_DANGEROUS

	var/datum/disease/advance/advanced_disease = new /datum/disease/advance/event(max_symptoms, requested_severity, requested_transmissibility)

	var/list/name_symptoms = list()
	for(var/datum/symptom/new_symptom as anything in advanced_disease.symptoms)
		name_symptoms += new_symptom.name

	illness_type = advanced_disease.name

	if(advanced_disease.spread_flags & DISEASE_SPREAD_AIRBORNE)
		for(var/datum/symptom/final_symptom in advanced_disease.symptoms)
			if(istype(final_symptom, /datum/symptom/cough) || istype(final_symptom, /datum/symptom/sneeze))
				announce_when = 22 // the most transmissible get an early announcement
				break

	// BUBBER EDIT ADDITION START - Disease Transmission
	var/to_infect = 3
	if(length(GLOB.alive_player_list) > 65)
		to_infect = 4

	var/infected = 0
	// BUBBER EDIT ADDITION END - Disease Transmission

	var/mob/living/carbon/human/victim
	while(length(afflicted) && infected < to_infect) // BUBBER EDIT CHANGE - Disease Transmission
		victim = pick_n_take(afflicted)
		if(victim.ForceContractDisease(advanced_disease, TRUE, infect_vector = "EVENT", final_infectivity = 100)) // BUBBER EDIT CHANGE - Disease Transmission
			message_admins("Event triggered: Disease Outbreak: Advanced - starting with patient zero [ADMIN_LOOKUPFLW(victim)]! Details: [advanced_disease.admin_details()] sp:[advanced_disease.spread_flags] ([advanced_disease.spread_text])")
			log_game("Event triggered: Disease Outbreak: Advanced - starting with patient zero [key_name(victim)]. Details: [advanced_disease.admin_details()] sp:[advanced_disease.spread_flags] ([advanced_disease.spread_text])")
			log_virus("Disease Outbreak: Advanced has triggered a custom virus outbreak of [advanced_disease.admin_details()] in [victim]!")
			log_public_file("Event virus details: [advanced_disease.admin_details()]")
			announce_to_ghosts(victim)
			infected++ // BUBBER EDIT ADDITION - Disease Transmission
			// return // BUBBER EDIT REMOVAL - Disease Transmission
		CHECK_TICK //don't lag the server to death
	if(isnull(victim))
		message_admins("Event Disease Outbreak: Advanced attempted to start, but failed to find a candidate target.")
		log_game("Event Disease Outbreak: Advanced attempted to start, but failed to find a candidate target.")
		return

	deadchat_broadcast("Disease Outbreak: Advanced starting with [advanced_disease.name]! Symptoms: [advanced_disease.symptoms_list()]")

/datum/disease/advance/event
	name = "Event Disease"
	copy_type = /datum/disease/advance
	bypasses_disease_recovery = TRUE
	event_disease = TRUE

/datum/round_event/disease_outbreak/advance/setup()
	announce_when = ADV_ANNOUNCE_DELAY

/**
 * Generate advanced virus
 *
 * Uses the parameters to create a list of symptoms, picking from various severities
 * Viral Evolution and Eternal Youth are special modifiers, so we roll separately.
 */
/datum/disease/advance/event/New(max_symptoms, requested_severity, requested_transmissibility)
	var/list/datum/symptom/possible_symptoms = list(
		/datum/symptom/beard,
		/datum/symptom/chills,
		/datum/symptom/confusion,
		/datum/symptom/cough,
		/datum/symptom/disfiguration,
		/datum/symptom/dizzy,
		/datum/symptom/fever,
		/datum/symptom/hallucigen,
		/datum/symptom/headache,
		/datum/symptom/itching,
		/datum/symptom/polyvitiligo,
		/datum/symptom/shedding,
		/datum/symptom/sneeze,
		/datum/symptom/voice_change,
	)

	switch(requested_severity)
		if(ADV_DISEASE_HARMFUL)
			possible_symptoms += list(
				/datum/symptom/choking,
				/datum/symptom/deafness,
				/datum/symptom/genetic_mutation,
				/datum/symptom/narcolepsy,
				/datum/symptom/vomit,
				/datum/symptom/weight_loss,
			)

		if(ADV_DISEASE_DANGEROUS)
			possible_symptoms += list(
				/datum/symptom/alkali,
				/datum/symptom/asphyxiation,
				/datum/symptom/fire,
				/datum/symptom/flesh_death,
				/datum/symptom/flesh_eating,
				/datum/symptom/visionloss,
			)

	visibility_flags |= HIDDEN_MEDHUD
	var/transmissibility = requested_transmissibility

	if(isnull(transmissibility))
		transmissibility = rand(1,100)

	if(requested_transmissibility == ADV_SPREAD_FORCED_LOW) // Admin forced
		set_spread(DISEASE_SPREAD_CONTACT_FLUIDS)

	else if(requested_transmissibility == ADV_SPREAD_FORCED_HIGH || transmissibility >= ADV_SPREAD_THRESHOLD)
		set_spread(DISEASE_SPREAD_AIRBORNE)
		if(prob(40))
			var/list/datum/symptom/airborne_modifiers = list(
				/datum/symptom/cough,
				/datum/symptom/sneeze,
			)
			var/datum/symptom/chosen_airborne = pick(airborne_modifiers)
			possible_symptoms -= chosen_airborne
			symptoms += new chosen_airborne

	else
		set_spread(DISEASE_SPREAD_CONTACT_SKIN)

	var/current_severity = 0

	while(symptoms.len < max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)

		if(!chosen_symptom)
			stack_trace("Advanced disease could not pick a symptom!")
			return

		//Checks if the chosen symptom is severe enough to meet requested severity. If not, pick a new symptom.
		//If we've met requested severity already, we don't care and will keep the chosen symptom.
		var/datum/symptom/new_symptom = new chosen_symptom

		if((current_severity < requested_severity) && (new_symptom.severity < requested_severity))
			continue

		symptoms += new_symptom

		if(new_symptom.severity > current_severity)
			current_severity = new_symptom.severity

	//Illness name from one of the symptoms
	var/datum/symptom/picked_name = pick(symptoms)
	name = picked_name.illness

	//Modifiers to keep the disease base stats above 0 (unless RNG gets a really bad roll.)
	//Eternal Youth for +4 to resistance and stage speed.
	//Viral modifiers to slow down/resist or go fast and loud.
	if(prob(66))
		var/list/datum/symptom/viral_modifiers = list(
			/datum/symptom/viraladaptation,
			/datum/symptom/viralevolution,
		)
		var/datum/symptom/chosen_viral = pick(viral_modifiers)
		symptoms += new chosen_viral
		symptoms += new /datum/symptom/youth

	Refresh()

/**
 * Assign virus properties
 *
 * Now that we've picked our symptoms and severity, we determine the other stats
 * (Stage Speed, Resistance, Transmissibility)
 * The LOW/MID percentiles can be adjusted in the defines.
 * If the virus is severity DANGEROUS we do not hide it from health scanners at event start.
 * If the virus is airborne, also don't hide it.
 */
/datum/disease/advance/event/assign_properties()

	if(!length(properties))
		stack_trace("Advanced virus properties were empty or null!")
		return

	// BUBBER EDIT CHANGE START - Disease Transmission
	//incubation_time = round(world.time + (((ADV_ANNOUNCE_DELAY * 2) - 10) SECONDS))
	//properties["transmittable"] = rand(4,7)
	//spreading_modifier = max(CEILING(0.4 * properties["transmittable"], 1), 1)
	properties["transmittable"] = rand(6,9)
	spreading_modifier = clamp(properties["transmittable"] - 5, 1, 4)
	infectivity = clamp(21 + (spreading_modifier * 7), 28, 56)
	cure_chance = rand(14, 21) // cure quickly once they've hit medbay
	stage_prob = rand(7, 9) * 0.1 // we progress slower than normal diseases, giving it a chance to incubate and medical to respond
	// BUBBER EDIT CHANGE END - Disease Transmission
	set_severity(properties["severity"])

	//If we have an advanced (high stage) disease, add it to the name.
	if(properties["stage_rate"] >= 7)
		name = "Advanced [name]"

	log_virus_debug("stage speed is [stage_prob], spreading modifier is [spreading_modifier], infectivity is [infectivity]") // BUBBER EDIT ADDITION - Disease Transmission
	generate_cure(properties)

/**
 * Set the transmission methods on the generated virus
 *
 * Apply the transmission methods we rolled in the assign_properties proc
 */
/datum/disease/advance/event/set_spread(spread_id)
	switch(spread_id)
		if(DISEASE_SPREAD_CONTACT_FLUIDS)
			update_spread_flags(DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS)
			spread_text = "Fluids"
		if(DISEASE_SPREAD_CONTACT_SKIN)
			update_spread_flags(DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN)
			spread_text = "Skin contact"
		if(DISEASE_SPREAD_AIRBORNE)
			update_spread_flags(DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_AIRBORNE)
			spread_text = "Respiration"

/**
 * Determine the cure
 *
 * Rolls one of five possible cure groups, then selects a cure from it and applies it to the virus.
 */
/datum/disease/advance/event/generate_cure()
	if(!length(properties))
		stack_trace("Advanced virus properties were empty or null!")
		return

	// BUBBER EDIT CHANGE START - Disease Transmission
	var/list/cures_list = advance_cures.Copy()
	if(properties["stage_rate"] >= 7)
		cures = list(pick_n_take(cures_list[rand(4, 7)]), pick_n_take(cures_list[3])) // require some help outside medbay (list 3)
		var/datum/reagent/cure_1 = GLOB.chemical_reagents_list[cures[1]]
		var/datum/reagent/cure_2 = GLOB.chemical_reagents_list[cures[2]]
		cure_text = "[cure_1.name] and [cure_2.name]"
	else
		cures = list(pick_n_take(cures_list[rand(4, 7)]))
		var/datum/reagent/cure_1 = GLOB.chemical_reagents_list[cures[1]]
		cure_text = cure_1.name
	// BUBBER EDIT CHANGE END - Disease Transmission

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
