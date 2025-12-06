/obj/machinery/rbmk2_sniffer/process()

	if(machine_stat & (NOPOWER|BROKEN))
		return FALSE

	var/highest_criticality = 0
	var/lowest_integrity_percent = 1
	var/has_meltdown = FALSE

	for(var/obj/machinery/power/rbmk2/reactor as anything in linked_reactors)
		if(!reactor)
			linked_reactors -= reactor
			continue
		if(!reactor.active)
			continue
		var/integrity_percent = reactor.get_integrity()/reactor.max_integrity
		if(integrity_percent <= lowest_integrity_percent)
			lowest_integrity_percent = integrity_percent
			if(lowest_integrity_percent <= 0.8)
				has_meltdown = TRUE
		if(reactor.meltdown)
			has_meltdown = TRUE
			if(reactor.criticality <= highest_criticality)
				continue
			highest_criticality = reactor.criticality

	var/alert_emergency_channel = highest_criticality >= 90 || lowest_integrity_percent <= 0.1

	if(alert_emergency_channel)
		alerted_emergency_channel = TRUE

	if(last_meltdown != has_meltdown) //Start of a meltdown.
		last_meltdown = has_meltdown
		if(last_meltdown)
			alert_radio(
				"Stray ionization detected! Reduce power output immediately!",
				bypass_cooldown=TRUE
			)
		else
			alert_radio(
				"Stray ionization no longer detected. Returning to safe operating parameters.",
				bypass_cooldown=TRUE,
				alert_emergency_channel=alerted_emergency_channel
			)
			alerted_emergency_channel = FALSE
		update_appearance(UPDATE_ICON)
	else if( highest_criticality >= 100 || abs(highest_criticality - last_criticality) >= 3 )
		last_criticality = highest_criticality
		if(highest_criticality >= 100)
			alert_radio(
				"CRITICALITY THRESHOLD MET! SEEK SHELTER IMMEDIATELY! CRITICALITY AT [round(last_criticality,0.1)]%!",
				bypass_cooldown=TRUE,
				alert_emergency_channel=alert_emergency_channel
			)
		else
			alert_radio(
				"Stray ionization detected! Criticality at [round(last_criticality,0.1)]%!",
				alert_emergency_channel=alert_emergency_channel
			)

	if(lowest_integrity_percent <= 0.8)
		last_integrity = lowest_integrity_percent
		if(abs(highest_criticality - last_criticality) >= 0.05 || lowest_integrity_percent <= 0.3)
			alert_radio(
				"[lowest_integrity_percent <= 0.3 ? "DANGER!" : "Warning!"] integrity at [round(lowest_integrity_percent*100,0.1)]%! Repairs required!",
				alert_emergency_channel=alert_emergency_channel,
				criticality=FALSE,
				bypass_cooldown=lowest_integrity_percent <= 0.1
			)


