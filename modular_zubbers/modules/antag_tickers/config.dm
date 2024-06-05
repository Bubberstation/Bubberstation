/datum/config_entry/number/antag_tickets_per_five_minutes
	default = 12
	integer = TRUE
	min_val = 0

/datum/config_entry/number/antag_ticket_maximum
	default = 60*3 //3 hours
	integer = TRUE
	min_val = 0

/datum/config_entry/number/antag_ticket_minimum
	default = -60*3 //-3 hours
	integer = TRUE
	max_val = 0