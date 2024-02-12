//digitigrade research

/datum/techweb_node/digitigradecyber
	id = "digitigradecyber"
	display_name = "Digitigrade Cybernetics"
	description = "Specialized cybernetic limb designs. The shortening of the femur is surely the result of mechanical optimization."
	prereq_ids = list("base")
	design_ids = list(
		"digitigradecyber_l_leg",
		"digitigradecyber_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)


/datum/techweb_node/adv_digitigradecyber
	id = "adv_digitigradecyber"
	display_name = "Advanced Digitigrade Cybernetics"
	description = "A step above consumer-grade digitigrade models, These have self-sharping claws for destroying your footwear much faster."
	prereq_ids = list("adv_robotics", "digitigradecyber")
	design_ids = list(
		"digitigradeadvanced_l_leg",
		"digitigradeadvanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500)
