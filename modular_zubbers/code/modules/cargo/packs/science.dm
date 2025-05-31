/datum/supply_pack/science/ai_uplink_brain
	name = "AI-Uplink Brain Crate"
	desc = "An experimental brain used to interface station Artificial Intelligences with a humanoid shell. \
		Contains one AI-Uplink brain, it will require anomaly cores to become functional."
	cost = CARGO_CRATE_VALUE * 50
	access = ACCESS_RD
	contains = list(/obj/item/organ/brain/cybernetic/ai/anomalock = 1)
	crate_name = "experimental ai-uplink brain interface crate"
	crate_type = /obj/structure/closet/crate/secure/science
	dangerous = TRUE
