/datum/map_template/shelter/plap
	name = "Portable Listening Post"
	shelter_id = "shelter_plap"
	description = "A cosy self-contained listening post, with \
		built-in cameras, medical records, PDA server spying and a \
		fax machine! Order now, and we'll throw in a photocopier, \
		absolutely free!"
	mappath = "_maps/templates/listeningbasics.dmm"

/datum/map_template/shelter/sauna
	name = "luxury hot tub and sauna survival pod"
	shelter_id = "shelter_s"
	description = "A cozy, heated, easily deployable luxury sauna when the heat, ash, and death of lavaland becomes too much. \
		Has a bult in personal locker space and dressing room to stow your equipment. \
		Requires a 10x10 space clear of obsticals. <span class ='red'><b>Warning: Deployment is rapid and explosive!</b></span>"
	mappath = "_maps/templates/shelter_s.dmm"

/datum/map_template/shelter/sauna/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)
