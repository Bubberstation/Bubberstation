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

/datum/techweb_node/borg_syndicate_module
	id = "borgsyndicatemodule"
	display_name = "Illegal Cyborg Modules"
	description = "Merges Pull Request #4678: \"Re-adds hidden cyborg modules\", with 2 upvotes and 2856 downvotes."
	design_ids = list("borg_syndicate_module")
	prereq_ids = list("syndicate_basic", "adv_robotics", "cyborg", "cyborg_upg_util", "cyborg_upg_serv", "cyborg_upg_engiminer", "cyborg_upg_med")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 15000)

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
