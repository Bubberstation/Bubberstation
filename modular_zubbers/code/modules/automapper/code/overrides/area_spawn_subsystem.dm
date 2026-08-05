/datum/area_spawn_over/big_bertha
	target_areas = list(
		/area/station/security/armory,
		/area/station/security/armory/upper
	)
	over_atoms = list(
		/obj/item/shield/riot
	)
	desired_atom = /obj/item/shield/big_bertha

/datum/area_spawn_over/big_bertha/New(...)
	. = ..()
	blacklisted_stations = null //Weird, but it werks.

/datum/area_spawn_over/security_missile_launcher
	target_areas = list(
		/area/station/security/armory,
		/area/station/security/armory/upper
	)
	over_atoms = list(
		/obj/item/gun/energy/temperature
	)
	desired_atom = /obj/item/gun/ballistic/rocketlauncher/security

/datum/area_spawn_over/security_missile_launcher/New(...)
	. = ..()
	blacklisted_stations = null //Weird, but it werks.

/datum/area_spawn_over/security_missile_launcher_ammo
	target_areas = list(
		/area/station/security/armory,
		/area/station/security/armory/upper
	)
	over_atoms = list(
		/obj/item/gun/energy/temperature
	)
	desired_atom = /obj/item/storage/box/security_missiles

/datum/area_spawn_over/security_missile_launcher_ammo/New(...)
	. = ..()
	blacklisted_stations = null //Weird, but it werks.
