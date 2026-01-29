#define FORCED_CASCADE 4

/datum/round_event_control/resonance_cascade
	name = "Supermatter Surge: Resonance Cascade"
	description = "Engineering has gone very wrong."
	typepath = /datum/round_event/resonance_cascade
	category = EVENT_CATEGORY_ENGINEERING
	weight = 0
	max_occurrences = 0
	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	admin_setup = list(/datum/event_admin_setup/warn_admin/resonance_cascade)
	tags = list(TAG_TARGETED)

/datum/event_admin_setup/warn_admin/resonance_cascade
	warning_text = "This is a round-ending event! Proceed anyways?"
	snitch_text = null //since this is not a conditional alert, there is nothing to snitch on. announcing a triggered event is enough.

/datum/event_admin_setup/warn_admin/resonance_cascade/should_warn()
	return TRUE

/datum/round_event/resonance_cascade
	announce_when = 4
	end_when = 256
	fakeable = FALSE
	var/obj/machinery/power/supermatter_crystal/sm
	var/event_stage = 1

/datum/round_event/resonance_cascade/announce(fake)
	SSsecurity_level.minimum_security_level(min_level = SEC_LEVEL_ORANGE, eng_access = TRUE, maint_access = FALSE)
	priority_announce("The Crystal Integrity Monitoring System has detected a critical threshold: HYPERSTRUCTURE OSCILLATION FREQUENCY OUT OF BOUNDS. Energy output from the supermatter crystal has increased significantly. Engineering intervention is required to stabilize the engine.", "Class R Supermatter Surge Alert", 'sound/machines/engine_alert/engine_alert3.ogg')

/datum/round_event/resonance_cascade/start()
	sm = GLOB.main_supermatter_engine
	if(isnull(sm))
		stack_trace("SM surge event failed to find a supermatter engine!")
		return

	apply_new_modifier(0.75)
	sm.bullet_energy = 64
	sm.set_delam(FORCED_CASCADE, /datum/sm_delam/cascade)

/datum/round_event/resonance_cascade/tick(seconds_between_ticks)
	if(event_stage == 1)
		if(activeFor <= 16)
			return

		apply_new_modifier(0.5)
		event_stage = 2
		return

	if(sm.absorbed_gasmix.temperature < sm.temp_limit)
		sm.damage += 0.7

	if(event_stage == 2)
		if(sm.damage <= 58)
			return

		SSsecurity_level.minimum_security_level(min_level = SEC_LEVEL_DELTA, eng_access = TRUE, maint_access = TRUE)
		priority_announce("Long range anomaly scans indicate abnormal quantities of harmonic flux originating from \
			a subject within [station_name()], a resonance collapse may occur.",
			"Nanotrasen Star Observation Association", 'sound/announcer/alarm/airraid.ogg'
		)
		event_stage = 3

	else if(event_stage == 3 && (sm.damage >= sm.explosion_point))
		end_when = activeFor + 1

/datum/round_event/resonance_cascade/proc/apply_new_modifier(new_modifier)
	for(var/i in 1 to sm.current_gas_behavior.len)
		var/gas_name = LAZYACCESS(sm.current_gas_behavior, i)
		var/datum/sm_gas/gas_type = sm.current_gas_behavior[gas_name]
		gas_type.powerloss_inhibition = abs(gas_type.powerloss_inhibition) + new_modifier
		gas_type.heat_power_generation = abs(gas_type.heat_power_generation) + new_modifier
		gas_type.heat_modifier = abs(gas_type.heat_modifier) + new_modifier

#undef FORCED_CASCADE
