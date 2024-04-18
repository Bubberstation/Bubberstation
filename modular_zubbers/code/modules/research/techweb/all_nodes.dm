// RESEARCH NODES

/datum/techweb_node/botanygene
	id = "botanygenes"
	display_name = "Experimental Botanical Engineering"
	description = "Botanical tools"
	prereq_ids = list("adv_engi", "biotech")
	design_ids = list(
		"diskplantgene",
		"plantgene",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	required_experiments = list(/datum/experiment/scanning/random/plants/wild)

// MEDICAL
/datum/techweb_node/adv_biotech/New()
	. = ..()
	design_ids += list(
		"crewmonitor",
	)
/datum/techweb_node/xenoorgan_biotech/New()
	. = ..()
	design_ids += list(
		"limbdesign_hemophage",
		"limbdesign_tajaran",
	)

// TOOLS

/datum/techweb_node/basic_mining/New()
	. = ..()
	design_ids += list(
		"interdyne_mining_equipment_vendor",
	)

// Robotics Tech

/datum/techweb_node/cyborg_upg_engiminer/New()
	. = ..()
	design_ids += list(
		"borg_upgrade_advcutter",
	)
// Computer Tech
/datum/techweb_node/computer_board_gaming/New()
	. = ..()
	design_ids += list(
		"minesweeper",
	)

//Weaponry Research

/datum/techweb_node/magazineresearch
	id = "storedmunition_tech"
	display_name = "Military Grade Munition Research"
	description = "In the wake of the NRI Border Conflict, there was a drive to advances our armament, learn how sol does it."
	prereq_ids = list("adv_weaponry")
	design_ids = list(
		"s12g_buckshot",
		"s12g_slug",
		"sol40_riflstandardemag",
		"solgrenade_extmag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 20000)

/datum/techweb_node/magazineresearch_heavy
	id = "storedmunition_tech_two"
	display_name = "Advanced Munition Research"
	description = "The same technology we used to defeat eldritch god, even you can have it"
	prereq_ids = list("syndicate_basic")
	design_ids = list(
		"sol40_rifldrummag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 45000)  //Unreasonably expensive and locked behind multiple tier of research, you can have abit of powercreep as a treat

/datum/techweb_node/weaponry/New()
	design_ids += "wt550_ammo_rubber"
	design_ids += "wt550_ammo_flathead"
	design_ids += "sol35_shortmag"
	design_ids += "m45_mag"
	design_ids += "s12g_hornet"
	design_ids += "s12g_antitide"
	design_ids += "s12g_rubber"
	design_ids += "s12g_bslug"
	design_ids += "s12g_incinslug"
	design_ids += "s12g_flechette"
	. = ..()

/datum/techweb_node/adv_weaponry/New()
	design_ids += "wt550_ammo_normal"
	design_ids += "sol35_shortextmag"
	design_ids += "sol40_riflemag"
	design_ids += "solgrenade_mag"
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	design_ids += "wt550_ammo_ap"
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	design_ids -= "mag_autorifle"
	design_ids -= "mag_autorifle_ap"
	design_ids -= "mag_autorifle_ic"
	design_ids += "wt550_ammo_incendiary"
	design_ids += "s12g_magnum"
	design_ids += "s12g_express"
	. = ..()
