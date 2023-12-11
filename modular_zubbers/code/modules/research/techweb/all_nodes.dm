// RESEARCH NODES
/*
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

// MODULAR ADDITIONS AND REMOVALS
*/
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

/datum/techweb_node/weaponry/New()
	design_ids += "wt550_ammo_rubber"
	design_ids += "wt550_ammo_flathead"
	. = ..()

/datum/techweb_node/adv_weaponry/New()
	design_ids += "wt550_ammo_normal"
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	design_ids += "wt550_ammo_ap"
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	design_ids -= "mag_autorifle"
	design_ids -= "mag_autorifle_ap"
	design_ids -= "mag_autorifle_ic"
	design_ids += "wt550_ammo_incendiary"
	. = ..()