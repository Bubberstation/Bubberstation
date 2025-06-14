// RESEARCH NODES
//Weaponry Research

/datum/techweb_node/magazineresearch
	id = "storedmunition_tech"
	display_name = "Ballisitic Research"
	description = "In the wake of the NRI Border Conflict, there was a drive to advances our armament, learn how sol does it."
	prereq_ids = list("exotic_ammo")
	design_ids = list(
		"s12g_buckshot"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/magazineresearch_romfed
	id = "storedmunition_tech_two"
	display_name = "Advanced Ballistic Research"
	description = "Catching up to the modern world in technological advancement, our enemies are everywhere and they are durable."
	prereq_ids = list("explosives","storedmunition_tech")
	design_ids = list(
		"s12g_db"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/basic_arms/New()
	design_ids += "s12c_fslug"
	design_ids += "s12g_huntingslug"

/datum/techweb_node/sec_equip/New()
	. = ..()

/datum/techweb_node/riot_supression/New()
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	. = ..()

/datum/techweb_node/electric_weapons/New()
	design_ids += "s12g_laser"
	. = ..()
