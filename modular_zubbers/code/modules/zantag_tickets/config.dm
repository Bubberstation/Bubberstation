//The amount of antag tickets a crewmember gets every 10 minutes.
/datum/config_entry/number/antag_tickets_per_update
	default = 10
	integer = TRUE
	min_val = 0

//The maximum possible amount of antag tickets someone can have.
/datum/config_entry/number/antag_ticket_maximum
	default = 60*3 //3 hours
	integer = TRUE
	min_val = 0

//The minimum possible amount of antag tickets someone can have. This should be a negative number.
//Use antag_ticket_base_weight instead if you want to give people with no tickets a better chance.
/datum/config_entry/number/antag_ticket_minimum
	default = 0
	integer = TRUE
	max_val = 0

//The amount of antagonist tickets a new player gets if they join for the first time (or somehow don't have an antag tickets value).
/datum/config_entry/number/antag_ticket_default
	default = 60
	integer = TRUE

//The base value for weight-based antag ticket rolling.
//For calculations, your final number would be this value + your current antag ticket count. This can be negative, but the final amount will always be at least the value of antag_ticket_roll_minimum .
/datum/config_entry/number/antag_ticket_base_weight
	default = 0
	integer = TRUE

//The minimum possible amount of antag tickets someone can for final calculations.
//Generally, you should set this to 0 to make it so that if you don't have antag tickets, you can't roll antag.
//Note that setting this to 0 means that if no one has enough antag tickets to become something, that antag can't roll.
/datum/config_entry/number/antag_ticket_final_minimum
	default = 1
	integer = TRUE
	min_val = 0


//The maximum amount of antag tickets you're allowed to gain per round.
/datum/config_entry/number/antag_ticket_max_earned_per_round
	default = 0
	integer = TRUE
	min_val = 0

//The maximum amount of antag tickets you're allowed to lose per round.
/datum/config_entry/number/antag_ticket_max_spent_per_round
	default = 120
	integer = TRUE
	min_val = 0

/datum/config_entry/flag/log_antag_tickets
