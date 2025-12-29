// Internal defines for cargo_pod event categories
// These are used to standardize need_category strings for consistency in storyteller planning
#define CARGO_NEED_GENERAL "general"        // Balanced/default supplies
#define CARGO_NEED_MEDICAL "medical"        // Health/disease crisis aid
#define CARGO_NEED_ENGINEERING "engineering"// Structural/infra damage repairs
#define CARGO_NEED_POWER "power"            // Power grid failures
#define CARGO_NEED_SECURITY "security"      // Antag threats/disruption
#define CARGO_NEED_RESOURCES "resources"    // Mineral/other resource shortages
#define CARGO_NEED_MORALE "morale"          // Crew mood boosters
#define CARGO_NEED_RESEARCH "research"      // Science progress enhancers

// Internal defines for good_level scaling (optional, if not using global STORY_USEFULNESS_LEVEL)
// These can be used for fine-tuning within the event
#define CARGO_GOOD_LEVEL_LOW 1              // Minimal aid
#define CARGO_GOOD_LEVEL_MODERATE 2         // Improved basics
#define CARGO_GOOD_LEVEL_HIGH 3             // Advanced + minor weapons
#define CARGO_GOOD_LEVEL_VERY_HIGH 4        // High-value + controlled lethals
#define CARGO_GOOD_LEVEL_EXTREME 5          // Premium + advanced weapons

/datum/round_event_control/cargo_pod
	id = "cargo_pod"
	name = "Cargo Pod Delivery"
	description = "A cargo pod has been dispatched to the station, containing supplies that could aid the crew in their duties."
	story_category = STORY_GOAL_GOOD
	tags = list(STORY_TAG_DEESCALATION, STORY_TAG_SOCIAL)
	typepath = /datum/round_event/storyteller_cargo_pod

	var/auto_cargo = FALSE

	var/list/base_cargo_by_level = list(
		list( // LOW
			/obj/item/stack/sheet/iron/fifty = 3,
			/obj/item/stack/sheet/glass/fifty = 2,
			/obj/item/stack/cable_coil/thirty = 2,
			/obj/item/storage/medkit = 1,
			/obj/item/reagent_containers/hypospray/medipen = 1
		),
		list( // MODERATE
			/obj/item/stack/sheet/plasteel/twenty = 3,
			/obj/item/stack/sheet/mineral/gold = 2,
			/obj/item/weldingtool = 2,
			/obj/item/storage/pill_bottle/happy = 1,
			/obj/item/storage/box/masks = 1,
			/obj/item/storage/toolbox/mechanical = 1
		),
		list( // HIGH
			/obj/item/stack/sheet/mineral/diamond = 3,
			/obj/item/stack/sheet/mineral/plasma = 2,
			/obj/item/storage/belt/medical = 2,
			/obj/item/defibrillator/compact = 1,
			/obj/item/melee/baton = 1,
			/obj/item/gun/energy/disabler = 1,
			/obj/item/clothing/suit/armor/vest = 1
		),
		list( // VERY_HIGH
			/obj/item/stack/sheet/mineral/titanium/fifty = 3,
			/obj/item/stack/sheet/bluespace_crystal = 2,
			/obj/item/mod/control/pre_equipped/medical = 2,
			/obj/item/gun/ballistic/shotgun/hook = 1,
			/obj/item/gun/energy/e_gun = 1,
			/obj/item/clothing/head/helmet/swat = 1,
			/obj/item/research_notes = 1
		),
		list( // EXTREME
			/obj/item/stack/sheet/mineral/adamantine = 3,
			/obj/item/stack/sheet/mineral/runite = 2,
			/obj/item/mod/control/pre_equipped/advanced = 2,
			/obj/item/gun/energy/lasercannon = 1,
			/obj/item/gun/ballistic/shotgun/bulldog = 1,
			/obj/item/storage/belt/security/full = 1,
			/obj/item/beacon = 1
		)
	)

	var/list/category_adds_by_level = list(
		list( // LOW
			CARGO_NEED_MEDICAL = list(/obj/item/storage/pill_bottle/epinephrine = 2),
			CARGO_NEED_ENGINEERING = list(/obj/item/stack/sheet/plasteel = 2),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell = 3, /obj/item/stack/cable_coil = 2),
			CARGO_NEED_SECURITY = list(/obj/item/clothing/suit/armor/vest = 1),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/iron/fifty = 3, /obj/item/stack/sheet/mineral/silver = 2),
			CARGO_NEED_MORALE = list(/obj/item/storage/box/donkpockets = 2, /obj/item/reagent_containers/cup/glass/bottle/beer = 3),
			CARGO_NEED_RESEARCH = list(/obj/item/disk/tech_disk = 1, /obj/item/stock_parts/scanning_module = 2)
		),
		list( // MODERATE
			CARGO_NEED_MEDICAL = list(/obj/item/storage/medkit/regular = 3, /obj/item/reagent_containers/hypospray/medipen = 2),
			CARGO_NEED_ENGINEERING = list(/obj/item/stack/sheet/plasteel/fifty = 2),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/high = 3, /obj/item/circuitboard/machine/cell_charger_multi = 1),
			CARGO_NEED_SECURITY = list(/obj/item/clothing/head/helmet = 2, /obj/item/flashlight/seclite = 1),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/silver = 2, /obj/item/stack/sheet/mineral/uranium = 1),
			CARGO_NEED_MORALE = list(/obj/item/storage/box/ingredients = 2, /obj/item/toy/plush = 1),
			CARGO_NEED_RESEARCH = list(/obj/item/stock_parts/servo = 2, /obj/item/research_notes = 1)
		),
		list( // HIGH
			CARGO_NEED_MEDICAL = list(/obj/item/storage/medkit/advanced = 2, /obj/item/reagent_containers/hypospray/medipen/atropine = 1),
			CARGO_NEED_ENGINEERING = list(/obj/item/storage/box/smart_metal_foam = 2, /obj/item/rcd_ammo = 1),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/super = 3, /obj/item/solar_assembly = 2),
			CARGO_NEED_SECURITY = list(/obj/item/clothing/suit/armor/riot = 1),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/titanium = 2),
			CARGO_NEED_MORALE = list(/obj/machinery/vending/snack = 1, /obj/item/toy/plush/tiredtesh = 2),
			CARGO_NEED_RESEARCH = list(/obj/item/stock_parts/scanning_module/adv = 2, /obj/item/disk/design_disk = 1)
		),
		list( // VERY_HIGH
			CARGO_NEED_MEDICAL = list(/obj/item/storage/medkit/fire = 2, /obj/item/organ/lungs/cybernetic/tier2 = 1),
			CARGO_NEED_ENGINEERING = list(/obj/item/construction/rcd/loaded = 1, /obj/item/stack/sheet/plasteel/fifty = 3),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/hyper = 3, /obj/machinery/power/smes = 1),
			CARGO_NEED_SECURITY = list(/obj/item/gun/ballistic/automatic/pistol = 1, /obj/item/clothing/suit/armor/swat = 1),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/adamantine = 2),
			CARGO_NEED_MORALE = list(/obj/machinery/vending/boozeomat = 1, /obj/item/instrument/piano_synth = 1),
			CARGO_NEED_RESEARCH = list(/obj/machinery/rnd/server = 1, /obj/item/stock_parts/servo/pico = 2)
		),
		list( // EXTREME
			CARGO_NEED_MEDICAL = list(/obj/item/storage/medkit/tactical = 3, /obj/item/organ/heart/cybernetic/tier3 = 1),
			CARGO_NEED_ENGINEERING = list(/obj/item/rcd_ammo/large = 2, /obj/item/stack/sheet/mineral/titanium/fifty = 3),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/bluespace = 3, /obj/machinery/power/rtg/advanced = 1),
			CARGO_NEED_SECURITY = list(/obj/item/gun/ballistic/rocketlauncher = 1, /obj/item/clothing/suit/armor/hos = 1),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/bananium = 2, /obj/item/stack/sheet/mineral/abductor = 1),
			CARGO_NEED_MORALE = list(/obj/item/storage/box/donkpockets = 3, /obj/machinery/computer/arcade = 1),
			CARGO_NEED_RESEARCH = list(/obj/item/disk/design_disk/long_range_pda = 2, /obj/item/stock_parts/scanning_module/phasic = 1)
		)
	)

	var/list/category_boosts_by_level = list(
		list( // LOW
			CARGO_NEED_MEDICAL = list(/obj/item/storage/medkit, /obj/item/reagent_containers/hypospray/medipen),
			CARGO_NEED_ENGINEERING = list(/obj/item/stack/sheet/iron/fifty, /obj/item/stack/sheet/glass/fifty),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell),
			CARGO_NEED_SECURITY = list(/obj/item/clothing/suit/armor/vest),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/iron/fifty),
			CARGO_NEED_MORALE = list(/obj/item/storage/box/donkpockets),
			CARGO_NEED_RESEARCH = list(/obj/item/disk/tech_disk)
		),
		list( // MODERATE
			CARGO_NEED_MEDICAL = list(/obj/item/storage/medkit/regular),
			CARGO_NEED_ENGINEERING = list(/obj/item/weldingtool, /obj/item/storage/toolbox/mechanical),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/high),
			CARGO_NEED_SECURITY = list(/obj/item/clothing/head/helmet),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/gold),
			CARGO_NEED_MORALE = list(/obj/item/storage/box/ingredients),
			CARGO_NEED_RESEARCH = list(/obj/item/research_notes)
		),
		list( // HIGH
			CARGO_NEED_MEDICAL = list(/obj/item/defibrillator/compact),
			CARGO_NEED_ENGINEERING = list(/obj/item/storage/box/smart_metal_foam),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/super),
			CARGO_NEED_SECURITY = list(/obj/item/melee/baton, /obj/item/gun/energy/disabler),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/diamond),
			CARGO_NEED_MORALE = list(/obj/item/toy/plush/tiredtesh),
			CARGO_NEED_RESEARCH = list(/obj/item/stock_parts/scanning_module/adv)
		),
		list( // VERY_HIGH
			CARGO_NEED_MEDICAL = list(/obj/item/mod/control/pre_equipped/medical),
			CARGO_NEED_ENGINEERING = list(/obj/item/construction/rcd/loaded),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/hyper),
			CARGO_NEED_SECURITY = list(/obj/item/gun/energy/e_gun),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/titanium/fifty),
			CARGO_NEED_MORALE = list(/obj/machinery/vending/boozeomat),
			CARGO_NEED_RESEARCH = list(/obj/item/research_notes)
		),
		list( // EXTREME
			CARGO_NEED_MEDICAL = list(/obj/item/storage/medkit/tactical),
			CARGO_NEED_ENGINEERING = list(/obj/item/mod/control/pre_equipped/advanced),
			CARGO_NEED_POWER = list(/obj/item/stock_parts/power_store/cell/bluespace),
			CARGO_NEED_SECURITY = list(/obj/item/gun/energy/lasercannon),
			CARGO_NEED_RESOURCES = list(/obj/item/stack/sheet/mineral/adamantine),
			CARGO_NEED_MORALE = list(/obj/item/storage/box/donkpockets),
			CARGO_NEED_RESEARCH = list(/obj/item/disk/design_disk/long_range_pda)
		)
	)

/datum/round_event_control/cargo_pod/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	. = ..()
	if(!auto_cargo)
		return

	// Calculate a "need_profile" based on key inputs metrics to prioritize cargo types
	// This analyzes station state: health, damage, resources, security, antag threats, etc.
	// We derive a primary "need_category" (e.g., medical, engineering, security) and a usefulness_level (1-5)
	// usefulness_level scales with threat_points or station distress (higher = better/more gear, with weapons from level 3+)
	// Use STORY_USEFULNESS_LEVEL(STORY_GOOD_POINTS(threat_points)) assuming defined macros for scaling (1 low threat, 5 high)
	var/good_level = STORY_USEFULNESS_LEVEL(STORY_GOOD_POINTS(threat_points))

	// Determine primary need_category by checking critical metrics in priority order
	var/need_category = CARGO_NEED_GENERAL  // Default to balanced supplies
	var/crew_health_level = inputs.get_entry(STORY_VAULT_CREW_HEALTH) || STORY_VAULT_HEALTH_NORMAL
	var/station_integrity = inputs.get_station_integrity() || 100
	var/infra_damage = inputs.get_entry(STORY_VAULT_INFRA_DAMAGE) || STORY_VAULT_NO_DAMAGE
	var/power_status = inputs.get_entry(STORY_VAULT_POWER_STATUS) || STORY_VAULT_FULL_POWER
	var/antag_activity = inputs.get_entry(STORY_VAULT_ANTAGONIST_ACTIVITY) || STORY_VAULT_NO_ACTIVITY
	var/low_resources = inputs.get_entry(STORY_VAULT_LOW_RESOURCE) || FALSE
	var/crew_morale = inputs.get_entry(STORY_VAULT_CREW_MORALE) || STORY_VAULT_MODERATE_MORALE
	var/research_progress = inputs.get_entry(STORY_VAULT_RESEARCH_PROGRESS) || STORY_VAULT_LOW_RESEARCH

	// Priority: Health crisis > Structural damage > Power issues > Antag threats > Resource shortages > Morale/Research
	if(crew_health_level >= STORY_VAULT_HEALTH_DAMAGED || inputs.get_entry(STORY_VAULT_CREW_DISEASES) >= STORY_VAULT_MINOR_DISEASES)
		need_category = CARGO_NEED_MEDICAL
	else if(station_integrity < 70 || infra_damage >= STORY_VAULT_MAJOR_DAMAGE)
		need_category = CARGO_NEED_ENGINEERING
	else if(power_status >= STORY_VAULT_LOW_POWER || inputs.get_entry(STORY_VAULT_POWER_GRID_DAMAGE) >= STORY_VAULT_POWER_GRID_FAILURES)
		need_category = CARGO_NEED_POWER
	else if(antag_activity >= STORY_VAULT_MODERATE_ACTIVITY || inputs.antag_crew_ratio() > 0.5 || inputs.get_entry(STORY_VAULT_ANTAG_DISRUPTION) >= STORY_VAULT_MAJOR_DISRUPTION)
		need_category = CARGO_NEED_SECURITY
	else if(low_resources || inputs.get_entry(STORY_VAULT_RESOURCE_MINERALS) < 100 || inputs.get_entry(STORY_VAULT_RESOURCE_OTHER) < 5000)
		need_category = CARGO_NEED_RESOURCES
	else if(crew_morale >= STORY_VAULT_LOW_MORALE)
		need_category = CARGO_NEED_MORALE
	else if(research_progress <= STORY_VAULT_LOW_RESEARCH)
		need_category = CARGO_NEED_RESEARCH

	// Now set possible_cargo as assoc list (path = weight) based on good_level and need_category
	// Weights for probabilistic selection; higher weight = more likely
	// Bias towards need_category items (higher weights), but include some general for variety
	// Scale quantity/quality: Level 1-2: Basic, no weapons; 3+: Include weapons/security if relevant
	// Adjust pod count or extras if high good_level (e.g., more pods for high threat)
	var/list/possible_cargo = _list_copy(base_cargo_by_level[good_level])
	var/base_weight_multiplier = 2  // Boost for need_category items

	var/list/cat_adds = category_adds_by_level[good_level]
	var/list/adds = cat_adds[need_category]
	if(adds)
		possible_cargo += adds

	var/list/cat_boosts = category_boosts_by_level[good_level]
	var/list/boosts = cat_boosts[need_category]
	if(boosts)
		for(var/path in boosts)
			possible_cargo[path] *= base_weight_multiplier

	// Global adjustments: If high antag influence or escalation, boost security items across levels (from 3+)
	if(good_level >= CARGO_GOOD_LEVEL_HIGH && (inputs.get_entry(STORY_VAULT_ANTAG_INFLUENCE) >= STORY_VAULT_HIGH_INFLUENCE || inputs.get_entry(STORY_VAULT_THREAT_ESCALATION) >= STORY_VAULT_FAST_ESCALATION))
		possible_cargo += list(/obj/item/clothing/suit/armor/riot = 2)  // Riot gear
		need_category = CARGO_NEED_SECURITY  // Override if threats are extreme

	// Ensure some randomness: If no specific need, mix categories
	if(need_category == CARGO_NEED_GENERAL)
		// Add a bit from each
		possible_cargo += list(/obj/item/storage/box/lights/mixed = 1)
	if(!length(possible_cargo))
		possible_cargo = pick(base_cargo_by_level)

	var/amount_of_pods = (good_level == CARGO_GOOD_LEVEL_LOW ? 1 : good_level == CARGO_GOOD_LEVEL_EXTREME ? 3 : good_level == CARGO_GOOD_LEVEL_HIGH ? 2 : rand(good_level - 1, good_level))

	var/list/possible_areas = list()
	switch(need_category)
		if(CARGO_NEED_MEDICAL)
			if(inputs.get_entry(STORY_VAULT_CREW_DISEASES) >= STORY_VAULT_MAJOR_DISEASES || inputs.get_entry(STORY_VAULT_CREW_HEALTH) >= STORY_VAULT_HEALTH_DAMAGED)
				possible_areas += get_areas(/area/station/medical)
		if(CARGO_NEED_ENGINEERING)
			if(inputs.get_entry(STORY_VAULT_INFRA_DAMAGE) >= STORY_VAULT_MAJOR_DAMAGE)
				possible_areas += get_areas(/area/station/engineering)
		if(CARGO_NEED_POWER)
			if(inputs.get_entry(STORY_VAULT_POWER_STATUS) >= STORY_VAULT_BLACKOUT)
				possible_areas += get_areas(/area/station/engineering)
		if(CARGO_NEED_SECURITY)
			if(inputs.get_entry(STORY_VAULT_ANTAGONIST_ACTIVITY) >= STORY_VAULT_HIGH_ACTIVITY)
				possible_areas += get_areas(/area/station/security)
		if(CARGO_NEED_RESOURCES)
			possible_areas += get_areas(/area/station/cargo)
		if(CARGO_NEED_MORALE)
			possible_areas += get_areas(/area/station/service)
		if(CARGO_NEED_RESEARCH)
			possible_areas += get_areas(/area/station/science)
		else
			possible_areas = GLOB.the_station_areas.Copy()

	additional_arguments = list(
		"possible_cargo" = possible_cargo,
		"amount_of_pods" = amount_of_pods,
		"possible_areas" = possible_areas
	)

/datum/round_event/storyteller_cargo_pod
	STORYTELLER_EVENT

	// Possible cargo to choose from
	var/list/possible_cargo = list()
	// Possible areas to spawn pods at
	var/list/possible_areas = list()
	// Chosen location to spawn drop pods
	var/turf/chosen_target_turf
	// Amount of pods to drop
	var/amount_of_pods = 1

	start_when = 20
	announce_when = 1

/datum/round_event/storyteller_cargo_pod/__setup_for_storyteller(threat_points, ...)
	. = ..()
	var/list/add_args = get_additional_arguments()
	possible_cargo = add_args["possible_cargo"] || list()
	amount_of_pods = add_args["amount_of_pods"] || 1
	possible_areas = add_args["possible_areas"] || list()

	chosen_target_turf = get_safe_random_station_turf(possible_areas)
	// Fallback if no valid turf found
	if(!chosen_target_turf)
		chosen_target_turf = get_safe_random_station_turf()

/datum/round_event/storyteller_cargo_pod/__announce_for_storyteller()
	priority_announce("A cargo pod is incoming to the station at [get_area(chosen_target_turf)], carrying supplies that could aid the crew.")


/datum/round_event/storyteller_cargo_pod/__start_for_storyteller()
	if(!chosen_target_turf)
		chosen_target_turf = get_safe_random_station_turf()

	notify_ghosts("Cargo pod delivery!", chosen_target_turf, "Cargo pods")
	for(var/i in 1 to amount_of_pods)
		// Slight offset for multiple pods to avoid overlap
		var/turf/pod_turf = i == 1 ? chosen_target_turf : locate(chosen_target_turf.x + rand(-2,2), chosen_target_turf.y + rand(-2,2), chosen_target_turf.z)
		if(!pod_turf || !is_station_level(pod_turf.z))
			continue
		var/num_items = rand(1, 3)
		var/list/paths_to_spawn = list()

		for(var/j in 1 to num_items)
			if(length(possible_cargo))
				var/chosen_item_path = pick_weight(possible_cargo)
				if(chosen_item_path)
					paths_to_spawn[chosen_item_path] = (paths_to_spawn[chosen_item_path] || 0) + 1
		paths_to_spawn[/obj/item/paper] = 1
		var/list/specifications = list(
			"target" = pod_turf,
			"style" = /datum/pod_style/centcom,
			"spawn" = paths_to_spawn,
			"explosionSize" = list(0,0,0,0)
		)
		var/obj/structure/closet/supplypod/podspawn/pod = podspawn(specifications)
		for(var/obj/item/paper/note in pod.contents)
			if(istype(note))
				note.add_raw_text("CentCom Supply Drop: Tailored for current needs. Contains multiple resources for enhanced support. Use it wisely.")
				break


#undef CARGO_NEED_GENERAL
#undef CARGO_NEED_MEDICAL
#undef CARGO_NEED_ENGINEERING
#undef CARGO_NEED_POWER
#undef CARGO_NEED_SECURITY
#undef CARGO_NEED_RESOURCES
#undef CARGO_NEED_MORALE
#undef CARGO_NEED_RESEARCH
#undef CARGO_GOOD_LEVEL_LOW
#undef CARGO_GOOD_LEVEL_MODERATE
#undef CARGO_GOOD_LEVEL_HIGH
#undef CARGO_GOOD_LEVEL_VERY_HIGH
#undef CARGO_GOOD_LEVEL_EXTREME
