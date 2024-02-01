//teshvali robolimb research node

/datum/techweb_node/teshvalicyber
	id = "teshvalicyber"
	display_name = "Raptoral Cybernetics"
	description = "Specialized cybernetic limb designs, courtesy of Ceremi Cybernetics."
	prereq_ids = list("base")
	design_ids = list(
		"teshvalicyber_chest",
		"teshvalicyber_l_arm",
		"teshvalicyber_r_arm",
		"teshvalicyber_l_leg",
		"teshvalicyber_r_leg",
		"teshvalicyber_head",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)


/datum/techweb_node/adv_teshvalicyber
	id = "adv_teshvalicyber"
	display_name = "Advanced Raptoral Cybernetics"
	description = "Some technologies from avali archaeological research efforts have been reverse-engineered."
	prereq_ids = list("adv_robotics", "teshvalicyber")
	design_ids = list(
		"teshvaliadvanced_l_arm",
		"teshvaliadvanced_r_arm",
		"teshvaliadvanced_l_leg",
		"teshvaliadvanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500)
