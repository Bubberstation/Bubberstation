/obj/item/hilbertshotel/ghostdojo
	name = "infinite dormitories"
	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

/obj/item/hilbertshotel/ghostdojo/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return promptAndCheckIn(user, user)

// borgos need love too
/obj/item/hilbertshotel/ghostdojo/attack_robot(mob/living/user)
	attack_hand(user)

/datum/map_template/ghost_cafe_rooms/apartment
	name = "Apartment"
	mappath = "modular_skyrat/modules/hotel_rooms/apartment.dmm"

/datum/map_template/ghost_cafe_rooms/beach_condo
	name = "Beach Condo"
	mappath = "modular_skyrat/modules/hotel_rooms/beach_condo.dmm"

/datum/map_template/ghost_cafe_rooms/stationside
	name = "Station Side"
	mappath = "modular_skyrat/modules/hotel_rooms/stationside.dmm"

/datum/map_template/ghost_cafe_rooms/library
	name = "Library"
	mappath = "modular_skyrat/modules/hotel_rooms/library.dmm"

/datum/map_template/ghost_cafe_rooms/cultcave
	name = "Cultist's Cavern"
	mappath = "modular_skyrat/modules/hotel_rooms/cultcave.dmm"

/datum/map_template/ghost_cafe_rooms/winterwoods
	name = "Winter Woods"
	mappath = "modular_skyrat/modules/hotel_rooms/winterwoods.dmm"

/area/misc/winterwoods
	name = "Winter Woods"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "hilbertshotel"
	requires_power = FALSE
	has_gravity = TRUE
	area_flags = NOTELEPORT | HIDDEN_AREA
	static_lighting = TRUE
	ambientsounds = "icemoon"
	var/roomnumber = 0
	var/obj/item/hilbertshotel/parentSphere
	var/datum/turf_reservation/reservation
	var/turf/storageTurf

/datum/map_template/ghost_cafe_rooms/evacuationstation
	name = "Evacuated Station"
	mappath = "modular_skyrat/modules/hotel_rooms/evacuationstation.dmm"

/datum/map_template/ghost_cafe_rooms/prisoninfdorm
	name = "Prison"
	mappath = "modular_skyrat/modules/hotel_rooms/prisoninfdorm.dmm"
