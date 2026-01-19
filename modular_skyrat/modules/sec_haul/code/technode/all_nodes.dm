// RESEARCH NODES
//Weaponry Research
/datum/techweb_node/ballistic
	id = "ballistic_tech"
	display_name = "Ballistic Research"
	description = "Ballistic ammunition for shotguns."
	prereq_ids = list(TECHWEB_NODE_RIOT_SUPRESSION)
	design_ids = list(
		"shotgun_slug",
		"buckshot_shell",
		"s12g_slug",
		"s12g_buckshot"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/magazineresearch
	id = "storedmunition_tech"
	display_name = "Ballisitic Research"
	description = "The daring do not stop at reaching the mountaintop, they go where no man has gone before" // and with that nice quote we have exotic ammo 2
	prereq_ids = list("exotic_ammo")
	design_ids = list(
		"s12g_db"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/basic_arms/New()
	design_ids += "s12c_fslug"
	design_ids += "s12g_huntingslug"
	design_ids += "ammoworkbench_disk_lethal"
	design_ids += "ammo_workbench"
	design_ids += "m9mm_sec"

/datum/techweb_node/sec_equip/New()
	. = ..()

/datum/techweb_node/riot_supression/New()
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	design_ids += "m9mm_sec_rocket"
	design_ids += "s12g_flechette"
	design_ids += "solgrenade_extmag"
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	. = ..()

/datum/techweb_node/electric_weapons/New()
	design_ids += "s12g_laser"
	. = ..()
