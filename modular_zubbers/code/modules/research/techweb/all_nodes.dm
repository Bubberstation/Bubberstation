// RESEARCH NODES

// cyber nodes
/datum/techweb_node/cyber/empathy_implant
	display_name = "Empathic Sensor Implant"
	description = "The result of assuredly-ethical experiments conducted on those with special minds."
	prerequisite_nodes = list(/datum/techweb_node/cyber/cyber_implants)
	unlocked_designs = list(
		/datum/design/empathic_sensor,
	)
	required_experiments = list(/datum/experiment/scanning/people/open_minds)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_implants/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/cyberimp_scanner,
		/datum/design/cyberimp_gloweyes,
		/datum/design/cyberimp_welding,
		/datum/design/cyberimp_medical_hud,
		/datum/design/cyberimp_security_hud,
		/datum/design/cyberimp_diagnostic_hud,
		/datum/design/cyberimp_civ_hud,
		/datum/design/cyberimp_botany,
		/datum/design/cyberimp_janitor,
		/datum/design/cyberimp_lighter,
		/datum/design/cyberimp_claws,
	)

/datum/techweb_node/cyber/cyber_organs_upgraded/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/limb_disk/adaptive_lungs,
	)
	unlocked_designs -= list(
		/datum/design/cyberimp_gloweyes,
		/datum/design/cyberimp_welding,
	)

/datum/techweb_node/cyber/combat_implants/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/cyberimp_mantis,
		/datum/design/cyberimp_flash,
		/datum/design/cyberimp_antisleep,
	)

/datum/techweb_node/cyber/night_vision_implants
	display_name = "Night vision implants"
	description = "Now you can work all night, even if you lost your glasses!"
	prerequisite_nodes = list(/datum/techweb_node/night_vision, /datum/techweb_node/cyber/cyber_implants)
	unlocked_designs = list(
		/datum/design/cyberimp_nv,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/botanygene
	display_name = "Experimental Botanical Engineering"
	description = "Further advancement in plant cultivation techniques and machinery, enabling careful manipulation of plant DNA."
	prerequisite_nodes = list(/datum/techweb_node/parts_adv, /datum/techweb_node/selection)
	unlocked_designs = list(
		/datum/design/diskplantgene,
		/datum/design/board/plantgenes,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)

/datum/techweb_node/parts_bluespace/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/experi_scanner/bluespace,
	)

//Research borg tech node
/datum/techweb_node/borg_research
	display_name = "Research Cyborg Upgrades"
	description = "They are taking our jobs now!"
	prerequisite_nodes = list(/datum/techweb_node/borg_engi, /datum/techweb_node/borg_medical)
	unlocked_designs = list(
		/datum/design/experi_scanner/bluespace_borg,
		/datum/design/borg_upgrade_advancedhealth,
		/datum/design/borg_upgrade_inducer_sci,
		/datum/design/borg_upgrade_brped,
		/datum/design/borg_upgrade_surgical_processor_sci,
		/datum/design/borg_upgrade_research_rcd
	)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)

//Mining borg upgrades
/datum/techweb_node/borg_mining/New()
	.=..()
	unlocked_designs += list(
		/datum/design/borg_upgrade_advcutter,
		/datum/design/borg_upgrade_welding,
	)


/datum/techweb_node/ai_laws/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/board/crewimov,
		/datum/design/board/crewimovpp,
		/datum/design/board/ntosthree
	)

// MEDICAL
/datum/techweb_node/cyber/cyber_implants/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/internal_wound_scanner
	)

/datum/techweb_node/medbay_equip/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/defibrillator,
	)

//ENGINEERING
/datum/techweb_node/atmos/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/nitrogen_tank,
		///datum/design/nitrogen_tank_belt, | Uncomment in case nitrogen internal tanks get refactored to no longer be 25L
		/datum/design/anesthetic_tank,
	)

// TOOLS

/datum/techweb_node/mining/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/board/interdyne_mining_equipment_vendor,
	)

// Robotics Tech

/datum/techweb_node/borg_engi/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/rld
	)

/datum/techweb_node/borg_utility/New()
	unlocked_designs += list(
		/datum/design/borg_upgrade_detailer,
		/datum/design/rld_janitor,
		/datum/design/cyborg_cable_coil,
	)
	return ..()

/datum/techweb_node/borg_medical/New()
	unlocked_designs += list(
		/datum/design/borg_upgrade_pinpointer,
	)
	return ..()

/datum/techweb_node/augmentation/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/synthclone,
		/datum/design/borg_dominatrix,
		/datum/design/borg_obedience,
		/datum/design/borg_upgrade_expand,
		/datum/design/borg_upgrade_shrink,
		/datum/design/borg_waddle
	)

/datum/techweb_node/borg_utility/New()
	. = ..()
	unlocked_designs -= list(
		/datum/design/borg_upgrade_expand, // Moved to default robotics, always available. It provides no practical benefit so it shouldn't be here
	)

/datum/techweb_node/borg_mining/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/pinpointer/vent,
		/datum/design/xenoarch/equipment/bag_adv_borg,
		/datum/design/kinetic_accelerator/railgun/cyborg,
		/datum/design/kinetic_accelerator/repeater/cyborg,
		/datum/design/kinetic_accelerator/shotgun/cyborg,
		/datum/design/kinetic_accelerator/glock/cyborg,
		/datum/design/kinetic_accelerator/shockwave/cyborg,
		/datum/design/kinetic_accelerator/m79/cyborg,
	)

/datum/techweb_node/mechlaunchpad
	display_name = "Mech Logistics Solutions"
	description = "Advancements in utilizing bluespace technology allow us to rapidly deliver mechs from workshop to destination."
	prerequisite_nodes = list(/datum/techweb_node/bluespace_travel, /datum/techweb_node/mech_equipment)
	unlocked_designs = list(
		/datum/design/board/mechpad,
		/datum/design/board/mechpad_console,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// Computer Tech
/datum/techweb_node/gaming/New()
	. = ..()
	unlocked_designs += list(
		/datum/design/board/minesweeper,
	)

// Security Tech

/datum/techweb_node/riot_supression/New()
	unlocked_designs += list(
		/datum/design/advancedgaugeboxes_rubbershot,
		/datum/design/advancedgaugeboxes_beanbagslug,
		/datum/design/advancedgaugeboxes_breaching,
		/datum/design/advancedgaugeboxes_incinslug,
		/datum/design/wt550_ammo,
		/datum/design/m9mm_mag,
		/datum/design/m45_mag,
		/datum/design/kiboko_mag,
		/datum/design/ntusp_conversion,
		/datum/design/ntusp_powerpack,
		/datum/design/ntmp5_powerpack,
	)
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	unlocked_designs += list(
		/datum/design/wt550_ammo_ap,
		/datum/design/wt550_ammo_compressed,
	)
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	unlocked_designs += list(
		/datum/design/wt550_ammo_incendiary,
		/datum/design/advancedgaugeboxes_db,
		/datum/design/module/mind_transfer,
	)
	. = ..()

/datum/techweb_node/bullet_weapons //This is for advanced bullet weapon designs and upgrades
	display_name = "Advanced Ballistic Weaponry"
	description = "As if shooting a bullet could get any more complicated."
	prerequisite_nodes = list(/datum/techweb_node/exotic_ammo)
	unlocked_designs = list(
		/datum/design/wt550kit_burst,
		/datum/design/wt550kit_long,
		/datum/design/simple_battle_rifle,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/advanced_armor //This is for advanced armor and shields
	display_name = "Advanced Security Protection"
	description = "If we can't hurt them, we can outlast them."
	prerequisite_nodes = list(/datum/techweb_node/riot_supression, /datum/techweb_node/gas_compression)
	unlocked_designs = list(
		/datum/design/juggernaut_suit_parts
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

// Modsuit tech
/datum/techweb_node/mod_equip/New()
	. = ..()
	unlocked_designs += list(/datum/design/module/mod_remote)

/datum/techweb_node/nerd
	display_name = "Theoretical Physics"
	description = "They asked me how well I understood theoretical physics. I said I had a theoretical degree in physics."
	prerequisite_nodes = list(/datum/techweb_node/robotics, /datum/techweb_node/chem_synthesis, /datum/techweb_node/mod_engi)
	unlocked_designs = list(
		/datum/design/nerd_suit,
		/datum/design/nerd_glasses
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS
	)

/datum/techweb_node/advanced_nerd
	display_name = "Advanced Theoretical Physics"
	description = "Scientists aren't supposed to have guns."
	prerequisite_nodes = list(
		/datum/techweb_node/alien/base, //Memes.
		/datum/techweb_node/anomaly_shells, //Physgun
		/datum/techweb_node/nerd, //Previous tier
		/datum/techweb_node/exp_tools, //Crowbar
	)
	unlocked_designs = list(
		/datum/design/physgun,
		/datum/design/fast_crowbar
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS
	)

/datum/techweb_node/mod_equip/New()
	unlocked_designs += list(
		/datum/design/module/protean/servo,
		/datum/design/module/hat_stabilizer,
	)
	. = ..()
