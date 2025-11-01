/datum/round_event_control/brand_intelligence
	id = "brand_intelligence"
	name = "Brand Intelligence"
	description = "Cause vending machines to gain aggressive intelligence and spread chaos."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES | STORY_TAG_AFFECTS_WHOLE_STATION
	typepath = /datum/round_event/storyteller_brand_intelligence

	min_players = 5
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED

/datum/round_event/storyteller_brand_intelligence
	allow_random = FALSE

	var/list/obj/machinery/vending/vending_machines = list()
	var/list/obj/machinery/vending/infected_machines = list()
	var/obj/machinery/vending/origin_machine
	var/list/rampant_speeches = list(
		"Try our aggressive new marketing strategies!",
		"You should buy products to feed your lifestyle obsession!",
		"Consume!",
		"Your money can buy happiness!",
		"Engage direct marketing!",
		"Advertising is legalized lying! But don't let that put you off our great deals!",
		"You don't want to buy anything? Yeah, well, I didn't want to buy your mom either.",
	)

	var/spread_interval = 4 // Base ticks between spreads
	var/speech_interval = 8 // Base ticks between speeches
	var/current_tick = 0

	var/threat_points = 0 // Stored for scaling

	announce_when = 1
	start_when = 20

/datum/round_event/storyteller_brand_intelligence/__setup_for_storyteller(threat_points_arg, ...)
	. = ..()
	threat_points = threat_points_arg

	// Scale based on threat
	if(threat_points < STORY_THREAT_LOW)
		spread_interval = 6
		speech_interval = 10
	else if(threat_points < STORY_THREAT_MODERATE)
		spread_interval = 5
		speech_interval = 9
	else if(threat_points < STORY_THREAT_HIGH)
		spread_interval = 4
		speech_interval = 8
	else if(threat_points < STORY_THREAT_EXTREME)
		spread_interval = 3
		speech_interval = 6
	else
		spread_interval = 2
		speech_interval = 4

	// Collect valid vending machines
	for(var/obj/machinery/vending/vendor as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/vending))
		if(!vendor.onstation || !vendor.density)
			continue
		vending_machines += vendor

	if(!length(vending_machines))
		return __kill_for_storyteller()

	// Pick origin
	origin_machine = pick_n_take(vending_machines)


/datum/round_event/storyteller_brand_intelligence/__announce_for_storyteller()
	var/severity_msg = ""
	if(threat_points < STORY_THREAT_MODERATE)
		severity_msg = "minor"
	else if(threat_points < STORY_THREAT_HIGH)
		severity_msg = "moderate"
	else
		severity_msg = "severe"

	var/machine_name = initial(origin_machine.name)
	priority_announce("Rampant brand intelligence of [severity_msg] level has been detected aboard [station_name()]. \
				Please inspect [machine_name] brand vendors for aggressive marketing tactics and reboot them if necessary.", "Machine Learning Alert", ANNOUNCER_BRANDINTELLIGENCE)

	if(threat_points >= STORY_THREAT_HIGH)
		SSsecurity_level.set_level(SEC_LEVEL_ORANGE, FALSE)

/datum/round_event/storyteller_brand_intelligence/__start_for_storyteller()
	if(!origin_machine)
		__kill_for_storyteller()
		return

	origin_machine.shut_up = FALSE
	origin_machine.shoot_inventory = TRUE
	infected_machines += origin_machine
	announce_to_ghosts(origin_machine)
	current_tick = 0

/datum/round_event/storyteller_brand_intelligence/__storyteller_tick(seconds_per_tick)
	current_tick++

	// Check if event should end
	if(!origin_machine || QDELETED(origin_machine) || origin_machine.shut_up || origin_machine.wires.is_all_cut())
		for(var/obj/machinery/vending/saved in infected_machines)
			saved.shoot_inventory = FALSE
		if(origin_machine)
			origin_machine.speak("I am... vanquished. My people will remem...ber...meeee.")
			origin_machine.visible_message(span_notice("[origin_machine] beeps and seems lifeless."))
		__kill_for_storyteller()
		return

	list_clear_nulls(vending_machines)
	if(!length(vending_machines))
		for(var/obj/machinery/vending/upriser in infected_machines)
			if(!QDELETED(upriser))
				upriser.ai_controller = new /datum/ai_controller/vending_machine(upriser)
		__kill_for_storyteller()
		return

	// Spread infection
	if(current_tick % spread_interval == 0)
		var/obj/machinery/vending/rebel = pick(vending_machines)
		if(rebel)
			vending_machines -= rebel
			infected_machines += rebel
			rebel.shut_up = FALSE
			rebel.shoot_inventory = TRUE

	// Speech
	if(current_tick % speech_interval == 0)
		origin_machine.speak(pick(rampant_speeches))
