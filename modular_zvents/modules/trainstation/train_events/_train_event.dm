/datum/round_event_control/train_event
	name = "Generic train event"
	description = "Train event? What even could be here?"
	category = "Trainstation"
	typepath = /datum/round_event/train_event
	weight = 0

/datum/round_event_control/train_event/can_spawn_event(players_amt, allow_magic)
	if(!SStrain_controller.mode_active)
		return FALSE
	return ..()

/datum/round_event/train_event
	fakeable = FALSE

/datum/round_event/train_event/New(my_processing = TRUE, datum/round_event_control/event_controller)
	. = ..()
	SSevents.running -= src
	SStrain_controller.running_events += src

/datum/round_event/train_event/kill()
	SStrain_controller.running_events -= src
