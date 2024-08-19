/datum/surgery/robot/cavity_implant
	name = "Cavity implant"
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/handle_cavity,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 2
	num_steps_until_closing = 4
	close_surgery = /datum/surgery/robot/close_cavity_implant

/datum/surgery/robot/close_cavity_implant
	name = "Close Surgery (Cavity implant)"
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
