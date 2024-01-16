//raptoral robolimb research node

/datum/techweb_node/raptoralcyber
	id = "raptoralcyber"
	display_name = "Raptoral Cybernetics"
	description = "Specialized cybernetic limb designs, courtesy of Ceremi Cybernetics."
	prereq_ids = list("base")
	design_ids = list(
		"raptoral_cyber_chest",
		"raptoral_cyber_l_arm",
		"raptoral_cyber_r_arm",
		"raptoral_cyber_l_leg",
		"raptoral_cyber_r_leg",
		"raptoral_cyber_head",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)


/datum/techweb_node/adv_raptoralcyber
	id = "adv_raptoralcyber"
	display_name = "Advanced Raptoral Cybernetics"
	description = "Some technologies from avali archaeological research efforts have been reverse-engineered."
	prereq_ids = list("adv_robotics", "raptoralcyber")
	design_ids = list(
		"raptoral_advanced_l_arm",
		"raptoral_advanced_r_arm",
		"raptoral_advanced_l_leg",
		"raptoral_advanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500)
