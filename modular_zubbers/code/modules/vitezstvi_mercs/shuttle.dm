/datum/map_template/shuttle/emergency/vitezstvi_mercs
	prefix = "_maps/shuttles/zubbers/"
	suffix = "merc"
	name = "VARS-7 'Provodnik' Contractor Shuttle"
	description = "Call in an old favor from Vítězství Arms and summon the VARS-7 'Provodnik', a heavily armed gunrunning cargo craft staffed by friendly contractors with more guns than sense. The extremely slurred speech you hear on the radio when communicating with these fellows makes you wonder if this is a good idea...."
	admin_notes = "Spawns four ghost role mercenaries via map-placed spawners in the bridge/security areas. \
		All four use /obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc. Friendly to crew. \
		Armed with Lanca rifle + Miecz SMG. Spawn with 15u vodka reagent (intentionally drunk). \
		Shuttle has station_crash/oh_no by design; it crashes into evac. This is intentional. \
		Unlock: complete any Vitezstvi Arms global bounty (vodka x8, Miecz x3, or CIN vest x4)."
	credit_cost = CARGO_CRATE_VALUE * 500
	occupancy_limit = "45 + 4 contractors"
	prerequisites = "Complete any Vítězství Arms bounty on the station bounty board this round."

/datum/map_template/shuttle/emergency/vitezstvi_mercs/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_VITEZSTVI]
