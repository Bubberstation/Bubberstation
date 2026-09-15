/datum/techweb_node/tarkon
	id = "tarkontech"
	display_name = "Tarkon Industries Technology"
	description = "Tools used by Tarkon Industries."
	required_items_to_unlock = list(
		/obj/item/mod/construction/plating/tarkon,
		/obj/item/construction/rcd/arcd/tarkon,
		/obj/item/gun/energy/recharge/resonant_system,
	)
	design_ids = list(
		"mod_plating_tarkon",
		"arcs",
		"rcd_tarkon",
		"powerator_tarkon",
		"cargoconsole_tarkon",
		"bountypad_tarkon",
		"bountyconsole_tarkon",
		"hackc"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	hidden = TRUE

/datum/techweb_node/tarkonturret
	id = "tarkondefence"
	display_name = "Tarkon Industries Defensive Technology"
	description = "Tarkon Industries Blackrust Salvage division's defense designs."
	prereq_ids = list(TECHWEB_NODE_TARKON, TECHWEB_NODE_BASIC_ARMS, TECHWEB_NODE_AI)
	required_items_to_unlock = list(
		/obj/item/mod/construction/plating/tarkon,
		/obj/item/construction/rcd/arcd/tarkon,
		/obj/item/gun/energy/recharge/resonant_system,
	)
	design_ids = list(
		"hoplite_assembly",
		"cerberus_assembly",
		"target_designator",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	hidden = TRUE

/datum/techweb_node/tarkon_borgs //Nor this, suprisingly
	id = "tarkon_borgs"
	display_name = "Tarkon Industries Robotics Technology"
	description = "Tarkon Industries Experimental Cyborg Prototypes. Not for public use."
	prereq_ids = list(TECHWEB_NODE_TARKON, TECHWEB_NODE_BORG_ENGI, TECHWEB_NODE_AI, TECHWEB_NODE_BORG_UTILITY) // Should hold it back long enough
	required_items_to_unlock = list(
		/obj/item/mod/construction/plating/tarkon,
		/obj/item/construction/rcd/arcd/tarkon,
		/obj/item/gun/energy/recharge/resonant_system,
	)
	design_ids = list(
		"borg_upgrade_tarkon_medical",
		"borg_upgrade_tarkon_engineering",
		"borg_upgrade_tarkon_security",
		"borg_upgrade_tarkon_cargo",
		"borg_upgrade_tarkon_research",
		"borg_upgrade_tarkon_service",
		"borg_upgrade_tarkon_janitor",
		"borg_upgrade_tarkon_main"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS) // They will likely have all other borg tech by now, no need to gate it further
	hidden = TRUE
