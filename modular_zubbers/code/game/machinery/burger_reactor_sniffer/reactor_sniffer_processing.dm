/obj/machinery/rbmk2_sniffer/process()

	if(machine_stat & (NOPOWER|BROKEN))
		return FALSE

	var/highest_criticality = 0
	var/has_meltdown = FALSE

	for(var/obj/machinery/power/rbmk2/reactor as anything in linked_reactors)
		if(!reactor.meltdown)
			continue
		has_meltdown = TRUE
		if(reactor.criticality <= highest_criticality)
			continue
		highest_criticality = reactor.criticality

	var/alert_emergency_channel = highest_criticality >= 70

	if(alert_emergency_channel)
		alerted_emergency_channel = TRUE

	if(last_meltdown != has_meltdown)
		last_meltdown = has_meltdown
		if(last_meltdown)
			alert_radio("Stray ionization detected! Reduce power output immediately!",alert_emergency_channel=alert_emergency_channel)
		else
			alert_radio("Stray ionization process halted. Returning to safe operating parameters.",alert_emergency_channel=alerted_emergency_channel)
			alerted_emergency_channel = FALSE
	else if( highest_criticality >= 100 || abs(highest_criticality - last_criticality) >= 3 )
		if(highest_criticality >= 100)
			alert_radio("CRITICALITY THRESHOLD MET! SEEK SHELTER IMMEDIATELY! CRITICALITY AT [round(last_criticality,0.1)]%!",alert_emergency_channel=alert_emergency_channel)
		else
			last_criticality = highest_criticality
			alert_radio("Stray ionization detected! Criticality at [round(last_criticality,0.1)]%!",alert_emergency_channel=alert_emergency_channel)

	update_appearance()