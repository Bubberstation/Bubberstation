/datum/blobstrain/
	var/instant_alert_on_change = FALSE

/datum/blobstrain/on_gain()
	. = ..()
	if(!has_announced && instant_alert_on_change)
		overmind.announcement_size = 0

/datum/blobstrain/reagent/networked_fibers
	instant_alert_on_change = TRUE



