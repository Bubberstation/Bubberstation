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
