/datum/area_spawn/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station", "Effigy RimPoint", "Effigy Sigma Octantis")
	. = ..()

/datum/area_spawn_over/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station", "Effigy RimPoint", "Effigy Sigma Octantis")
	. = ..()

/datum/area_spawn_over/big_bertha
	target_areas = list(
		/area/station/ai_monitored/security/armory,
		/area/station/ai_monitored/security/armory/upper
	)
	over_atoms = list(
		/obj/item/shield/riot
	)
	desired_atom = /obj/item/shield/big_bertha

/datum/area_spawn_over/big_bertha/New(...)
	. = ..()
	blacklisted_stations = null //Weird, but it werks.
