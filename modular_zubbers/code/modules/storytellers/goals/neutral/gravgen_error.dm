/datum/round_event_control/gravity_generator_blackout
	id = "gravity_generator_error"
	story_category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_AFFECTS_ENVIRONMENT
	typepath = /datum/round_event/gravity_generator_blackout
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

/datum/round_event_control/gravity_generator_malfunction
	name = "Gravity Generator Malfunction"
	description = "The station's gravity generators are malfunctioning, \
		causing unpredictable gravity fluctuations throughout the station."
	id = "gravity_generator_malfunction"
	story_category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_AFFECTS_ENVIRONMENT
	typepath = /datum/round_event/storyteller_gravgen_malfunction
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

	map_flags = EVENT_SPACE_ONLY

/datum/round_event_control/gravity_generator_malfunction
	name = "Gravity Generator Malfunction"
	description = "The station's gravity generators are malfunctioning, \
		causing unpredictable gravity fluctuations throughout the station."
	id = "gravity_generator_malfunction"
	story_category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_AFFECTS_ENVIRONMENT
	typepath = /datum/round_event/storyteller_gravgen_malfunction
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

	map_flags = EVENT_SPACE_ONLY

/datum/round_event/storyteller_gravgen_malfunction
	STORYTELLER_EVENT

	var/fluctuation_cooldown = 30 SECONDS
	var/force_strength_min = 3

	var/datum/weakref/gravity_gen_ref
	var/list/signals_to_add

	COOLDOWN_DECLARE(gravity_fluctuation_cooldown)

/datum/round_event/storyteller_gravgen_malfunction/__setup_for_storyteller(threat_points, ...)
	. = ..()

	if(threat_points < STORY_THREAT_LOW)
		force_strength_min = 2
	else if(threat_points < STORY_THREAT_MODERATE)
		force_strength_min = 3
	else if(threat_points < STORY_THREAT_HIGH)
		force_strength_min = 4
	else if(threat_points < STORY_THREAT_EXTREME)
		force_strength_min = 5
	else
		force_strength_min = 6

	end_when = 240

/datum/round_event/storyteller_gravgen_malfunction/__announce_for_storyteller()
	priority_announce("Gravity generator malfunction detected. Crew may experience sudden gravitational \
							fluctuations, causing disorientation and potential physical displacement.")

/datum/round_event/storyteller_gravgen_malfunction/__start_for_storyteller()
	var/obj/machinery/gravity_generator/main/gravity_gen
	for(var/obj/machinery/gravity_generator/main/G in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/gravity_generator/main))
		if(is_station_level(G.z))
			gravity_gen = G
			break

	if(!gravity_gen)
		return // No gravity generator found, cancel the event

	gravity_gen_ref = WEAKREF(gravity_gen)

	// Select repair methods similar to radiation leak
	var/list/how_do_we_fix_it = list(
		"wrenching a few valves" = TOOL_WRENCH,
		"tightening its bolts" = TOOL_WRENCH,
		"crowbaring its panel [pick("down", "up")]" = TOOL_CROWBAR,
		"tightening some screws" = TOOL_SCREWDRIVER,
		"checking its [pick("wires", "circuits")]" = TOOL_MULTITOOL,
		"welding its panel [pick("open", "shut")]" = TOOL_WELDER,
		"analyzing its readings" = TOOL_ANALYZER,
		"cutting some excess wires" = TOOL_WIRECUTTER,
	)
	var/list/fix_it_keys = assoc_to_keys(how_do_we_fix_it)

	var/list/methods_to_fix = list()
	for(var/i in 1 to rand(1, 5))
		methods_to_fix += pick_n_take(fix_it_keys)

	// Construct the signals
	signals_to_add = list()
	for(var/tool_method in methods_to_fix)
		signals_to_add += COMSIG_ATOM_TOOL_ACT(how_do_we_fix_it[tool_method])

	gravity_gen.visible_message(span_danger("[gravity_gen] starts humming erratically, emitting sparks!"))
	// Add a component to indicate malfunction (optional, for visual/radiation effects if desired)
	gravity_gen.AddComponent(/datum/component/radioactive_emitter, \
		cooldown_time = 5 SECONDS, \
		range = 3, \
		threshold = RAD_MEDIUM_INSULATION, \
		examine_text = span_danger("It's malfunctioning! You could probably fix it by [english_list(methods_to_fix, and_text = " or ")]."), \
	)

	if(length(signals_to_add))
		RegisterSignals(gravity_gen, signals_to_add, PROC_REF(on_gravgen_tooled), TRUE)

	// Initial effects
	do_sparks(5, FALSE, gravity_gen)
	playsound(gravity_gen, 'sound/effects/empulse.ogg', 50, vary = TRUE)

	COOLDOWN_START(src, gravity_fluctuation_cooldown, fluctuation_cooldown)


/datum/round_event/storyteller_gravgen_malfunction/__storyteller_tick(seconds_per_tick)
	var/obj/machinery/gravity_generator/main/gravity_gen = gravity_gen_ref.resolve()
	if(!gravity_gen.on)
		return
	if(!COOLDOWN_FINISHED(src, gravity_fluctuation_cooldown))
		return
	COOLDOWN_START(src, gravity_fluctuation_cooldown,  fluctuation_cooldown)
	var/wave_direction = pick(GLOB.cardinals)

	for(var/mob/living/living_target in get_alive_station_crew(FALSE, FALSE, FALSE,FALSE))
		var/turf/target_turf = get_ranged_target_turf(living_target, wave_direction, rand(force_strength_min, force_strength_min + 2))
		if(!HAS_TRAIT(src, TRAIT_NEGATES_GRAVITY) && !isspaceturf(get_turf(living_target)))
			living_target.throw_at(target_turf, get_dist(living_target, target_turf), 1)
			shake_camera(living_target, 2, 1)
			to_chat(living_target, span_warning("A sudden gravitational shift throws you off balance!"))
		for(var/atom/movable/AM in get_nearest_atoms(living_target, /atom/movable, 7))
			if(AM.anchored || !istype(AM) || isspaceturf(get_turf(AM)))
				continue
			var/turf/AM_target = get_ranged_target_turf(AM, wave_direction, rand(force_strength_min - 1, force_strength_min + 1))
			AM.throw_at(AM_target, get_dist(AM, AM_target), 1)


/datum/round_event/storyteller_gravgen_malfunction/__end_for_storyteller()
	. = ..()
	priority_announce("Gravity generator stabilized. Fluctuations have ceased.")
	var/obj/machinery/gravity_generator/main/gravity_gen = gravity_gen_ref?.resolve()
	if(gravity_gen)
		qdel(gravity_gen.GetComponent(/datum/component/radioactive_emitter))
		if(length(signals_to_add))
			UnregisterSignal(gravity_gen, signals_to_add)
	gravity_gen_ref = null
	signals_to_add = null

/datum/round_event/storyteller_gravgen_malfunction/proc/on_gravgen_tooled(obj/machinery/source, mob/living/user, obj/item/tool)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(try_repair_gravgen), source, user, tool)
	return ITEM_INTERACT_BLOCKING

/datum/round_event/storyteller_gravgen_malfunction/proc/try_repair_gravgen(obj/machinery/source, mob/living/user, obj/item/tool)
	source.balloon_alert(user, "repairing malfunction...")
	if(!tool.use_tool(source, user, 10 SECONDS, amount = (tool.tool_behaviour == TOOL_WELDER ? 2 : 0), volume = 50))
		source.balloon_alert(user, "interrupted!")
		return

	source.balloon_alert(user, "malfunction repaired")
	// Force end the event
	processing = FALSE
	__end_for_storyteller()
