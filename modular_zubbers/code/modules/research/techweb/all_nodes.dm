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

/datum/techweb_node/nerd
	id = "nerd"
	display_name = "Theoretical Physics"
	description = "They asked me how well I understood theoretical physics. I said I had a theoretical degree in physics."
	prereq_ids = list(
		"robotics", //Suit AI
		"biotech", //Wound analyzer (and morphine production).
		"mod_engineering" //Suit protection.
	)
	design_ids = list(
		"nerd_suit",
		"nerd_glases"
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 4000
	)

/datum/techweb_node/advanced_nerd
	id = "advanced_nerd"
	display_name = "Advanced Theoretical Physics"
	description = "Scientists aren't supposed to have guns."
	prereq_ids = list(
		"alientech", //Memes.
		"gravity_gun", //Physgun
		"nerd", //Previous tier
		"exp_tools" //Crowbar
	)
	design_ids = list(
		"physgun",
		"fast_crowbar"
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 10000
	)

