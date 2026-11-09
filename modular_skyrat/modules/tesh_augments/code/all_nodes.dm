//teshari_ robolimb research node

/datum/techweb_node/teshari_cyber
	display_name = "Raptoral Cybernetics"
	description = "Specialized civilian-grade cybernetic limb designs."
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/teshari_cyber_chest,
		/datum/design/teshari_cyber_l_arm,
		/datum/design/teshari_cyber_r_arm,
		/datum/design/teshari_cyber_l_leg,
		/datum/design/teshari_cyber_r_leg,
		/datum/design/teshari_cyber_head,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/adv_teshari_cyber
	display_name = "Advanced Raptoral Cybernetics"
	description = "Specialized industrial-grade cybernetic limb designs."
	prerequisite_nodes = list(/datum/techweb_node/cybernetics, /datum/techweb_node/teshari_cyber)
	unlocked_designs = list(
		/datum/design/teshari_advanced_l_arm,
		/datum/design/teshari_advanced_r_arm,
		/datum/design/teshari_advanced_l_leg,
		/datum/design/teshari_advanced_r_leg,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
