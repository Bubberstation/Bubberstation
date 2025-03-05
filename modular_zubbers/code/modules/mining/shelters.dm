/datum/map_template/shelter/plap
	name = "Portable Listening Post"
	shelter_id = "shelter_plap"
	description = "A cosy self-contained listening post, with \
		built-in cameras, medical records, PDA server spying and a \
		fax machine! Order now, and we'll throw in a photocopier, \
		absolutely free!"
	mappath = "_maps/bubber/pods/listeningbasics.dmm"

/datum/map_template/shelter/sauna
	name = "luxury hot tub and sauna survival pod"
	shelter_id = "shelter_s"
	description = "A cozy, heated, easily deployable luxury sauna when the heat, ash, and death of lavaland becomes too much. \
		Has a bult in personal locker space and dressing room to stow your equipment. \
		Requires a 10x10 space clear of obsticals. <span class ='red'><b>Warning: Deployment is rapid and explosive!</b></span>"
	mappath = "_maps/bubber/pods/shelter_s.dmm"

/datum/map_template/shelter/sauna/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/delta
	name = "Shelter Delta"
	shelter_id = "shelter_delta"
	description = "An emergency medical pod, comes with stasis beds and surgical suites. \
		Deploy to prevent death."
	mappath = "_maps/bubber/pods/shelter_4.dmm"

/datum/map_template/shelter/delta/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/echo
	name = "Shelter Echo"
	shelter_id = "shelter_echo"
	description = "A pod for harvesting geysers"
	mappath = "_maps/bubber/pods/shelter_5.dmm"

/datum/map_template/shelter/echo/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)
