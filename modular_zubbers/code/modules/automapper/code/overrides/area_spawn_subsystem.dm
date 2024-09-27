/datum/area_spawn/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station")
	. = ..()

/datum/area_spawn_over/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station")
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

/datum/area_spawn_over/precision_ion
	target_areas = list(
		/area/station/ai_monitored/security/armory,
		/area/station/ai_monitored/security/armory/upper
	)
	over_atoms = list(
		/obj/item/gun/energy/ionrifle
	)
	desired_atom = /obj/item/gun/energy/ionrifle/precision

/datum/area_spawn_over/precision_ion/New(...)
	. = ..()
	blacklisted_stations = null //Weird, but it werks.