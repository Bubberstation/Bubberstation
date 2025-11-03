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
	tags = STORY_TAG_AFFECTS_CREW_MIND | STORY_TAG_AFFECTS_RESOURCES
	typepath = /datum/round_event/storyteller_cargo_pod

	var/auto_cargo = FALSE

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
	var/list/possible_cargo = list()
	var/base_weight_multiplier = 2  // Boost for need_category items
	var/amount_of_pods = 1
	switch(good_level)
		if(CARGO_GOOD_LEVEL_LOW)  // Low: Basic essentials, focus on minimal aid
			possible_cargo += list(
				/obj/item/stack/sheet/iron/fifty = 3,          // Basic construction
				/obj/item/stack/sheet/glass/fifty = 2,         // Repairs
				/obj/item/stack/cable_coil/thirty = 2,         // Wiring
				/obj/item/storage/medkit = 1,                  // Basic medkit
				/obj/item/reagent_containers/hypospray/medipen = 1  // Quick heal
			)
			if(need_category == CARGO_NEED_MEDICAL)
				possible_cargo[/obj/item/storage/medkit] *= base_weight_multiplier
				possible_cargo[/obj/item/reagent_containers/hypospray/medipen] *= base_weight_multiplier
				possible_cargo += list(/obj/item/storage/pill_bottle/epinephrine = 2)  // Stabilizers
			else if(need_category == CARGO_NEED_ENGINEERING)
				possible_cargo[/obj/item/stack/sheet/iron/fifty] *= base_weight_multiplier
				possible_cargo[/obj/item/stack/sheet/glass/fifty] *= base_weight_multiplier
				possible_cargo += list(/obj/item/stack/sheet/plasteel = 2)  // Basic reinforcements
			else if(need_category == CARGO_NEED_POWER)
				possible_cargo += list(/obj/item/stock_parts/power_store/cell = 3, /obj/item/stack/cable_coil = 2)  // Basic cells and cables
				possible_cargo[/obj/item/stock_parts/power_store/cell] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_SECURITY)
				possible_cargo += list(/obj/item/clothing/suit/armor/vest = 1)
				possible_cargo[/obj/item/clothing/suit/armor/vest] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_RESOURCES)
				possible_cargo += list(/obj/item/stack/sheet/iron/fifty = 3, /obj/item/stack/sheet/mineral/silver = 2)
				possible_cargo[/obj/item/stack/sheet/iron/fifty] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_MORALE)
				possible_cargo += list(/obj/item/storage/box/donkpockets = 2, /obj/item/reagent_containers/cup/glass/bottle/beer = 3)  // Food/drinks
				possible_cargo[/obj/item/storage/box/donkpockets] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_RESEARCH)
				possible_cargo += list(/obj/item/disk/tech_disk = 1, /obj/item/stock_parts/scanning_module = 2)
				possible_cargo[/obj/item/disk/tech_disk] *= base_weight_multiplier
			amount_of_pods = 1

		if(CARGO_GOOD_LEVEL_MODERATE)  // Moderate: Improved basics, tools
			possible_cargo += list(
				/obj/item/stack/sheet/plasteel/twenty = 3,     // Stronger material
				/obj/item/stack/sheet/mineral/gold = 2,        // Value resource
				/obj/item/weldingtool = 2,                     // Repair tool
				/obj/item/storage/pill_bottle/happy = 1,       // Mood pills
				/obj/item/storage/box/masks = 1,               // Basic protection
				/obj/item/storage/toolbox/mechanical = 1       // Toolbox
			)
			if(need_category == CARGO_NEED_MEDICAL)
				possible_cargo += list(/obj/item/storage/medkit/regular = 3, /obj/item/reagent_containers/hypospray/medipen = 2)
				possible_cargo[/obj/item/storage/medkit/frontier] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_ENGINEERING)
				possible_cargo[/obj/item/weldingtool] *= base_weight_multiplier
				possible_cargo[/obj/item/storage/toolbox/mechanical] *= base_weight_multiplier
				possible_cargo += list(/obj/item/stack/sheet/plasteel/fifty = 2)
			else if(need_category == CARGO_NEED_POWER)
				possible_cargo += list(/obj/item/stock_parts/power_store/cell/high = 3, /obj/item/circuitboard/machine/cell_charger_multi = 1)  // Power cells and parts
				possible_cargo[/obj/item/stock_parts/power_store/cell/high] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_SECURITY)
				possible_cargo += list(/obj/item/clothing/head/helmet = 2, /obj/item/flashlight/seclite = 1)
				possible_cargo[/obj/item/clothing/head/helmet] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_RESOURCES)
				possible_cargo[/obj/item/stack/sheet/mineral/gold] *= base_weight_multiplier
				possible_cargo += list(/obj/item/stack/sheet/mineral/silver = 2, /obj/item/stack/sheet/mineral/uranium = 1)
			else if(need_category == CARGO_NEED_MORALE)
				possible_cargo += list(/obj/item/storage/box/ingredients = 2, /obj/item/toy/plush = 1)  // Food and fun
				possible_cargo[/obj/item/storage/box/ingredients] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_RESEARCH)
				possible_cargo += list(/obj/item/stock_parts/servo = 2, /obj/item/research_notes = 1)
				possible_cargo[/obj/item/stock_parts/scanning_module] *= base_weight_multiplier
			amount_of_pods = rand(1, 2)

		if(CARGO_GOOD_LEVEL_HIGH)  // High: Advanced resources + minor weapons (non-lethal/basic)
			possible_cargo += list(
				/obj/item/stack/sheet/mineral/diamond = 3,     // High-value
				/obj/item/stack/sheet/mineral/plasma = 2,      // Energy
				/obj/item/storage/belt/medical = 2,            // Med belt
				/obj/item/defibrillator/compact = 1,           // Defib
				/obj/item/melee/baton = 1,                     // Stun baton (minor weapon)
				/obj/item/gun/energy/disabler = 1,             // Non-lethal gun
				/obj/item/clothing/suit/armor/vest = 1         // Basic armor
			)
			if(need_category == CARGO_NEED_MEDICAL)
				possible_cargo[/obj/item/defibrillator/compact] *= base_weight_multiplier
				possible_cargo += list(/obj/item/storage/medkit/advanced = 2, /obj/item/reagent_containers/hypospray/medipen/atropine = 1)
			else if(need_category == CARGO_NEED_ENGINEERING)
				possible_cargo += list(/obj/item/storage/box/smart_metal_foam = 2, /obj/item/rcd_ammo = 1)
				possible_cargo[/obj/item/storage/box/smart_metal_foam] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_POWER)
				possible_cargo += list(/obj/item/stock_parts/power_store/cell/super = 3, /obj/item/solar_assembly = 2)
				possible_cargo[/obj/item/stock_parts/power_store/cell/super] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_SECURITY)
				possible_cargo[/obj/item/melee/baton] *= base_weight_multiplier
				possible_cargo[/obj/item/gun/energy/disabler] *= base_weight_multiplier
				possible_cargo += list(/obj/item/clothing/suit/armor/riot = 1)
			else if(need_category == CARGO_NEED_RESOURCES)
				possible_cargo[/obj/item/stack/sheet/mineral/diamond] *= base_weight_multiplier
				possible_cargo += list(/obj/item/stack/sheet/mineral/titanium = 2)
			else if(need_category == CARGO_NEED_MORALE)
				possible_cargo += list(/obj/machinery/vending/snack = 1, /obj/item/toy/plush/tiredtesh = 2)  // Vending or toys
				possible_cargo[/obj/item/toy/plush/tiredtesh] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_RESEARCH)
				possible_cargo += list(/obj/item/stock_parts/scanning_module/adv = 2, /obj/item/disk/design_disk = 1)
				possible_cargo[/obj/item/stock_parts/scanning_module/adv] *= base_weight_multiplier
			amount_of_pods = 2

		if(CARGO_GOOD_LEVEL_VERY_HIGH)  // Very high: High-value + better weapons (lethal controlled)
			possible_cargo += list(
				/obj/item/stack/sheet/mineral/titanium/fifty = 3,  // Elite material
				/obj/item/stack/sheet/bluespace_crystal = 2,       // Teleport tech
				/obj/item/mod/control/pre_equipped/medical = 2,	   // Med MOD
				/obj/item/gun/ballistic/shotgun/hook = 1,          // Hookshot (utility weapon)
				/obj/item/gun/energy/e_gun = 1,                    // Energy gun (lethal)
				/obj/item/clothing/head/helmet/swat = 1,           // Better helmet
				/obj/item/research_notes = 1                       // Research boost
			)
			if(need_category == CARGO_NEED_MEDICAL)
				possible_cargo[/obj/item/mod/control/pre_equipped/medical] *= base_weight_multiplier
				possible_cargo += list(/obj/item/storage/medkit/fire = 2, /obj/item/organ/lungs/cybernetic/tier2 = 1)
			else if(need_category == CARGO_NEED_ENGINEERING)
				possible_cargo += list(/obj/item/construction/rcd/loaded = 1, /obj/item/stack/sheet/plasteel/fifty = 3)
				possible_cargo[/obj/item/construction/rcd/loaded] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_POWER)
				possible_cargo += list(/obj/item/stock_parts/power_store/cell/hyper = 3, /obj/machinery/power/smes = 1)
				possible_cargo[/obj/item/stock_parts/power_store/cell/hyper] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_SECURITY)
				possible_cargo[/obj/item/gun/energy/e_gun] *= base_weight_multiplier
				possible_cargo += list(/obj/item/gun/ballistic/automatic/pistol = 1, /obj/item/clothing/suit/armor/swat = 1)
			else if(need_category == CARGO_NEED_RESOURCES)
				possible_cargo[/obj/item/stack/sheet/mineral/titanium/fifty] *= base_weight_multiplier
				possible_cargo += list(/obj/item/stack/sheet/mineral/adamantine = 2)
			else if(need_category == CARGO_NEED_MORALE)
				possible_cargo += list(/obj/machinery/vending/boozeomat = 1, /obj/item/instrument/piano_synth = 1)
				possible_cargo[/obj/machinery/vending/boozeomat] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_RESEARCH)
				possible_cargo[/obj/item/research_notes] *= base_weight_multiplier
				possible_cargo += list(/obj/machinery/rnd/server = 1, /obj/item/stock_parts/servo/pico = 2)
			amount_of_pods = rand(2, 3)

		if(CARGO_GOOD_LEVEL_EXTREME)  // Extreme: Premium gear + advanced weapons
			possible_cargo += list(
				/obj/item/stack/sheet/mineral/adamantine = 3,// Mythical
				/obj/item/stack/sheet/mineral/runite = 2,          // Rare
				/obj/item/mod/control/pre_equipped/advanced = 2,   // Elite engi suit
				/obj/item/gun/energy/lasercannon = 1,              // Powerful laser
				/obj/item/gun/ballistic/shotgun/bulldog = 1,       // Advanced shotgun
				/obj/item/storage/belt/security/full = 1,          // Full sec belt
				/obj/item/beacon = 1							   // Emergency beacon
			)
			if(need_category == CARGO_NEED_MEDICAL)
				possible_cargo += list(/obj/item/storage/medkit/tactical = 3, /obj/item/organ/heart/cybernetic/tier3 = 1)
				possible_cargo[/obj/item/storage/medkit/tactical] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_ENGINEERING)
				possible_cargo[/obj/item/mod/control/pre_equipped/advanced] *= base_weight_multiplier
				possible_cargo += list(/obj/item/rcd_ammo/large = 2, /obj/item/stack/sheet/mineral/titanium/fifty = 3)
			else if(need_category == CARGO_NEED_POWER)
				possible_cargo += list(/obj/item/stock_parts/power_store/cell/bluespace = 3, /obj/machinery/power/rtg/advanced = 1)
				possible_cargo[/obj/item/stock_parts/power_store/cell/bluespace] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_SECURITY)
				possible_cargo[/obj/item/gun/energy/lasercannon] *= base_weight_multiplier
				possible_cargo += list(/obj/item/gun/ballistic/rocketlauncher = 1, /obj/item/clothing/suit/armor/hos = 1)
			else if(need_category == CARGO_NEED_RESOURCES)
				possible_cargo += list(/obj/item/stack/sheet/mineral/bananium = 2, /obj/item/stack/sheet/mineral/abductor = 1)
				possible_cargo[/obj/item/stack/sheet/mineral/adamantine] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_MORALE)
				possible_cargo += list(/obj/item/storage/box/donkpockets = 3, /obj/machinery/computer/arcade = 1)  // Food and games
				possible_cargo[/obj/item/storage/box/donkpockets] *= base_weight_multiplier
			else if(need_category == CARGO_NEED_RESEARCH)
				possible_cargo += list(/obj/item/disk/design_disk/long_range_pda = 2, /obj/item/stock_parts/scanning_module/phasic = 1)
				possible_cargo[/obj/item/disk/design_disk/long_range_pda] *= base_weight_multiplier
			amount_of_pods = 3

	// Global adjustments: If high antag influence or escalation, boost security items across levels (from 3+)
	if(good_level >= CARGO_GOOD_LEVEL_HIGH && (inputs.get_entry(STORY_VAULT_ANTAG_INFLUENCE) >= STORY_VAULT_HIGH_INFLUENCE || inputs.get_entry(STORY_VAULT_THREAT_ESCALATION) >= STORY_VAULT_FAST_ESCALATION))
		possible_cargo += list(/obj/item/clothing/suit/armor/riot = 2)  // Riot gear
		need_category = CARGO_NEED_SECURITY  // Override if threats are extreme

	// Ensure some randomness: If no specific need, mix categories
	if(need_category == CARGO_NEED_GENERAL)
		// Add a bit from each
		possible_cargo += list(/obj/item/storage/box/lights/mixed = 1)
	var/possible_areas = list()
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
