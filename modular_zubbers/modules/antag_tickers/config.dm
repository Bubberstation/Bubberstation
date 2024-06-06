/datum/config_entry/number/antag_tickets_per_update //Each update is typically 10 minutes.
	default = 10 //10 per 10 minutes
	integer = TRUE
	min_val = 0

/datum/config_entry/number/antag_ticket_maximum
	default = 60*3 //3 hours
	integer = TRUE
	min_val = 0

/datum/config_entry/number/antag_ticket_minimum
	default = 0
	integer = TRUE
	max_val = 0

/datum/config_entry/number/antag_ticket_default
	default = 60
	integer = TRUE
