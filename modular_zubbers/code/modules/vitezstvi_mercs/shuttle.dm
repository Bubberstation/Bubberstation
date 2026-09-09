/datum/map_template/shuttle/emergency/vitezstvi_mercs
	prefix = "_maps/shuttles/zubbers/"
	suffix = "merc"
	name = "VARS-7 'Provodnik' Contractor Shuttle"
	description = "Call in an old favor from Vítězství Arms and summon the VARS-7 'Provodnik', a heavily armed gunrunning cargo craft staffed by friendly contractors with more guns than sense. The extremely slurred speech you hear on the radio when communicating with these fellows makes you wonder if this is a good idea...."
	admin_notes = "Spawns four drunk idiots that try to rescue the crew, then crashes into a random room on the station. Teehee."
	credit_cost = CARGO_CRATE_VALUE * 500
	occupancy_limit = "45 + 4 contractors"
	prerequisites = "Complete any Vítězství Arms bounty on the station bounty board this round."

/datum/map_template/shuttle/emergency/vitezstvi_mercs/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_VITEZSTVI]
