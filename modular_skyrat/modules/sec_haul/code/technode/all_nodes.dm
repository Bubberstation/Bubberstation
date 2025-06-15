// RESEARCH NODES
//Weaponry Research

/datum/techweb_node/magazineresearch
	id = "storedmunition_tech"
	display_name = "Ballistic Research"
	description = "In the wake of the CIN Border Conflict, we found ourselves surrounded by enemies of science and progress, to fight them, we must adapt."
	prereq_ids = list("exotic_ammo")
	design_ids = list(
		"solgrenade_extmag",
		"sol35_shortextmag",
		"ca_flech",
		"ca_flechmagnesium",
		"s12g_slug",
		"s12c_antitide",
		"s12g_buckshot"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/magazineresearch_romfed
	id = "storedmunition_tech_two"
	display_name = "Improved Ballistic Research"
	description = "There was a time where folklores were dismissed as mere oral tradition, we predicted a cataclysmic have lead to destruction of the previous empires. We will be ready this time."
	prereq_ids = list("explosives","storedmunition_tech")
	design_ids = list(
		"s12g_flechette",
		"s12g_db"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/basic_arms/New()
	design_ids += "sol35_shortmag"
	design_ids += "c10mm_r"
	design_ids += "c10mm_rihdf"
	design_ids += "s12c_fslug"
	design_ids += "ammoworkbench_disk_lethal"
	design_ids += "ammo_workbench"
	design_ids += "s12g_huntingslug"

/datum/techweb_node/magazineresearch_heavy
	id = "storedmunition_tech_three"
	display_name = "Advanced Munitions"
	description = "The absolute pinnacle limited by only what our fabricators can physically produces, anything beyond this may aswell be magic."
	prereq_ids = list("syndicate_basic","storedmunition_tech_two")
	design_ids = list(
		"m9mm_mag_ext_hp",
		"m9mm_mag_ext",
		"m9mm_mag_ext_b",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/sec_equip/New()
	design_ids += "m45_mag"
	design_ids += "s12g_rubber"
	design_ids += "s12g_bslug"
	design_ids += "c457_casing"
	design_ids += "m9mm_mag_rubber"
	design_ids += "c10mm_rl"
	. = ..()

/datum/techweb_node/riot_supression/New()
	design_ids += "s12g_hornet"
	design_ids += "s12g_br"
	design_ids += "m9mm_mag_ihdf"
	design_ids += "ca_flechballpoint"
	design_ids += "m9mm_mag"
	design_ids += "c10mm_rincin"
	design_ids += "s12g_antitide"
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	design_ids += "s12g_incinslug"
	design_ids += "ca_flechripper"
	design_ids += "c10mm_rhp"
	design_ids += "c10mm_rap"
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	design_ids += "s12g_magnum"
	design_ids += "s12g_express"
	design_ids += "s12g_ion"
	. = ..()

/datum/techweb_node/electric_weapons/New()
	design_ids += "s12g_laser"
	. = ..()
