//digitigrade research

/datum/techweb_node/digitigrade_cyber
	display_name = "Digitigrade Cybernetics"
	description = "Specialized cybernetic limb designs. The shortening of the femur is surely the result of mechanical optimization."
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		"digitigrade_cyber_l_leg",
		"digitigrade_cyber_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/adv_digitigrade_cyber
	display_name = "Advanced Digitigrade Cybernetics"
	description = "A step above consumer-grade digitigrade models, these have self-sharpening claws for destroying your footwear much faster."
	prerequisite_nodes = list(/datum/techweb_node/augmentation)
	unlocked_designs = list(
		"digitigrade_advanced_l_leg",
		"digitigrade_advanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
