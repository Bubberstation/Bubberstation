// RESEARCH NODES
//Weaponry Research
/datum/techweb_node/ballistic
	display_name = "Ballistic Research"
	description = "Ballistic ammunition for shotguns."
	prerequisite_nodes = list(/datum/techweb_node/riot_supression)
	unlocked_designs = list(
		/datum/design/shotgun_slug,
		/datum/design/buckshot_shell,
		/datum/design/advancedgaugeboxes_slug,
		/datum/design/advancedgaugeboxes
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/basic_arms/New()
	unlocked_designs += list(
		/datum/design/s12c_fslug,
		/datum/design/advancedgaugeboxes_hunting,
		/datum/design/disk/ammo_workbench_lethal,
		/datum/design/disk/ammo_workbench_lethal,
		/datum/design/board/ammo_workbench,
		/datum/design/m9mm_sec,
		/datum/design/m9mm_sec_speedloader,
		/datum/design/c32_speedloader,
	)
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	unlocked_designs += list(
		/datum/design/m9mm_sec_rocket,
		/datum/design/advancedgaugeboxes_flech,
		/datum/design/kiboko_box_mag,
	)
	. = ..()

/datum/techweb_node/electric_weapons/New()
	unlocked_designs += /datum/design/advancedgaugeboxes_laser
	. = ..()
