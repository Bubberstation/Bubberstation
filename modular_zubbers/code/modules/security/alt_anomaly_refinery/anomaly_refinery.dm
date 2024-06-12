#define REFINERY_ANOMALY_REFINEMENT_TIME (5 SECONDS)
#define REFINERY_ANOMALY_POWER_REQUIREMENT (1.21 MEGA WATTS) //This is NOT active power use. This is the amount of power it uses for a second when a bomb is detonated.

/obj/machinery/research/anomaly_refinery
	desc = "An advanced machine equipped with state of the art bomb prediction software that's capable of implosion-compressing raw anomaly cores into finished artifacts. \
	Comes with a built-in stabilization and sound-supressant field that consumes a lot of power to prevent obnoxious shaking and sounds heard station-wide, as not to wake up any dorms users."
	var/requirement_timer
	var/requirement_mod = 0 //0 to 100. Decreases by 1 every 5 seconds. Increased by 40 after a test.

/obj/machinery/research/anomaly_refinery/examine(mob/user)
	. = ..()
	. += span_notice("Usage of the machine will increase the bomb range requirement for the next experiment, however this diminishes with time.")
	. += span_notice("Requires <b>[display_power(REFINERY_ANOMALY_POWER_REQUIREMENT)]</b> of power in the network to use.")
	. += span_notice("Each core refinement takes <b>[DisplayTimeText(REFINERY_ANOMALY_REFINEMENT_TIME,1)]</b> to complete.")

/obj/machinery/research/anomaly_refinery/get_required_radius(anomaly_type)
	var/explosion_range = max(GLOB.MAX_EX_DEVESTATION_RANGE,GLOB.MAX_EX_HEAVY_RANGE,GLOB.MAX_EX_LIGHT_RANGE,0)
	var/explosion_mod = 0.25 + (requirement_mod/100)*0.75
	return round(explosion_range * explosion_mod,1)

/obj/machinery/research/anomaly_refinery/start_test()

	if (active)
		say("ERROR: Already running a compression test.")
		return

	if(!istype(inserted_core) || !istype(inserted_bomb))
		end_test("ERROR: Missing equpment. Items ejected.")
		return

	if(!inserted_bomb?.tank_one || !inserted_bomb?.tank_two || !(tank_to_target == inserted_bomb?.tank_one || tank_to_target == inserted_bomb?.tank_two))
		end_test("ERROR: Transfer valve malfunctioning. Items ejected.")
		return

	if(!use_power_from_net(REFINERY_ANOMALY_POWER_REQUIREMENT))
		say("ERROR: Not enough power in network to safely compress the core.")
		return

	say("Beginning compression test. Opening transfer valve.")
	active = TRUE
	test_status = null

	inserted_bomb.toggle_valve(tank_to_target)

	requirement_mod = min(requirement_mod + 20, 100) + round(REFINERY_ANOMALY_REFINEMENT_TIME/5,1)

	timeout_timer = addtimer(CALLBACK(src, PROC_REF(timeout_test)), REFINERY_ANOMALY_REFINEMENT_TIME, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME | TIMER_NO_HASH_WAIT)
	requirement_timer = addtimer(CALLBACK(src, PROC_REF(remove_requirement)), 5 SECONDS, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_DELETE_ME | TIMER_NO_HASH_WAIT | TIMER_LOOP)

	say("Refining core. ETA [DisplayTimeText(REFINERY_ANOMALY_REFINEMENT_TIME,1)] until core refinement completion.")

	playsound(
		src,
		pick('modular_zubbers/sound/arcade/minesweeper_explosion1.ogg','modular_zubbers/sound/arcade/minesweeper_explosion2.ogg','modular_zubbers/sound/arcade/minesweeper_explosion3.ogg'),
		50
	)

	return

/obj/machinery/research/anomaly_refinery/proc/remove_requirement()

	requirement_mod = max(0,requirement_mod-1)

	if(requirement_mod <= 0)
		deltimer(requirement_timer)
		requirement_timer = null
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_boardpress.ogg'),
			50
		)
		say("Anomaly stability now at 100%.")

/obj/machinery/research/anomaly_refinery/check_test(atom/source, list/arguments)

	if(!inserted_core)
		test_status = "ERROR: No core present during detonation."
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_winfail.ogg'),
			50
		)
		return COMSIG_CANCEL_EXPLOSION

	var/heavy = arguments[EXARG_KEY_DEV_RANGE]
	var/medium = arguments[EXARG_KEY_HEAVY_RANGE]
	var/light = arguments[EXARG_KEY_LIGHT_RANGE]
	var/explosion_range = max(heavy, medium, light, 0)
	var/required_range = get_required_radius(inserted_core.anomaly_type)
	var/turf/location = get_turf(src)

	var/cap_multiplier = SSmapping.level_trait(location.z, ZTRAIT_BOMBCAP_MULTIPLIER)
	if(isnull(cap_multiplier))
		cap_multiplier = 1
	var/capped_heavy = min(GLOB.MAX_EX_DEVESTATION_RANGE * cap_multiplier, heavy)
	var/capped_medium = min(GLOB.MAX_EX_HEAVY_RANGE * cap_multiplier, medium)

	if(explosion_range < required_range)
		test_status = "Resultant detonation failed to produce enough implosive power to compress [inserted_core]. Items ejected."
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_winfail.ogg'),
			50
		)
		return COMSIG_CANCEL_EXPLOSION

	if(test_status)
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_winfail.ogg'),
			50
		)
		return COMSIG_CANCEL_EXPLOSION

	inserted_core = inserted_core.create_core(src, TRUE, TRUE)
	test_status = "Success. Resultant detonation has theoretical range of [explosion_range]. Required radius was [required_range]. Core production complete."

	playsound(
		src,
		pick('modular_zubbers/sound/arcade/minesweeper_win.ogg'),
		50
	)

	return COMSIG_CANCEL_EXPLOSION

#undef REFINERY_ANOMALY_REFINEMENT_TIME
#undef REFINERY_ANOMALY_POWER_REQUIREMENT
