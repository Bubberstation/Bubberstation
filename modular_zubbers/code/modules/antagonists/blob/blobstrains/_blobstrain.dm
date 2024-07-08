/datum/blobstrain/
	var/instant_alert_on_change = FALSE

/datum/blobstrain/reagent/networked_fibers/on_gain()
	. = ..()
	if(instant_alert_on_change)
		announcement_size = 0

/datum/blobstrain/reagent/networked_fibers
	instant_alert_on_change = TRUE



