/datum/storyteller_metric
	var/name = "Generic check"


/datum/storyteller_metric/proc/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return TRUE


/datum/storyteller_metric/proc/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	set waitfor = FALSE

	SHOULD_CALL_PARENT(TRUE)
	if(anl)
		anl.try_stop_analyzing(src)

