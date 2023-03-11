/datum/component/temporary_pollution_emission
	dupe_mode = COMPONENT_DUPE_ALLOWED
	/// The type of the pollutant we're emitting
	var/pollutant_type
	/// The amount we emitt every process
	var/pollutant_amount
	/// When do we expire
	var/expiry_time

/datum/component/temporary_pollution_emission/Initialize(pollutant_type, pollutant_amount, expiry_time)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	src.pollutant_type = pollutant_type
	src.pollutant_amount = pollutant_amount
	src.expiry_time = world.time + expiry_time
	RegisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT, PROC_REF(wash_off))
	START_PROCESSING(SSobj, src)

/datum/component/temporary_pollution_emission/Destroy()
	UnregisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT)
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/component/temporary_pollution_emission/process(delta_time = SSOBJ_DT)
	var/turf/my_turf = get_turf(parent)
	if(!my_turf || world.time >= expiry_time)
		qdel(src)
		return

	my_turf.pollute_turf(pollutant_type, pollutant_amount * delta_time)

/datum/component/temporary_pollution_emission/proc/wash_off()
	SIGNAL_HANDLER
	if(ismob(parent))
		to_chat(parent, span_notice("The smell that lingered on your body fades."))
	qdel(src)
