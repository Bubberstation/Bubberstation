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

/area/misc/hilbertshotel/winterwoods
	name = "Winter Woods"
	ambience_index = AMBIENCE_ICEMOON

/datum/map_template/ghost_cafe_rooms/evacuationstation
	name = "Evacuated Station"
	mappath = "modular_skyrat/modules/hotel_rooms/evacuationstation.dmm"

/datum/map_template/ghost_cafe_rooms/prisoninfdorm
	name = "Prison"
	mappath = "modular_skyrat/modules/hotel_rooms/prisoninfdorm.dmm"

/datum/map_template/ghost_cafe_rooms/corporateoffice
	name = "Corporate Office"
	mappath = "modular_skyrat/modules/hotel_rooms/corporateoffice.dmm"

/datum/map_template/ghost_cafe_rooms/recwing
	name = "Recovery Wing"
	mappath = "modular_skyrat/modules/hotel_rooms/recovery.dmm"

/datum/map_template/ghost_cafe_rooms/grotto
	name = "Grotto"
	mappath = "modular_skyrat/modules/hotel_rooms/grotto.dmm"

/datum/map_template/ghost_cafe_rooms/grotto2
	name = "Grotto (Night)"
	mappath = "modular_skyrat/modules/hotel_rooms/grottoalt.dmm"

/datum/map_template/ghost_cafe_rooms/foxbar
	name = "Fox Bar"
	mappath = "modular_skyrat/modules/hotel_rooms/foxbar.dmm"

/datum/map_template/ghost_cafe_rooms/nightclub
	name = "The Nightclub"
	mappath = "modular_skyrat/modules/hotel_rooms/nightclub.dmm"

/datum/map_template/ghost_cafe_rooms/eva
	name = "EVA"
	mappath = "modular_skyrat/modules/hotel_rooms/eva.dmm"

/datum/map_template/ghost_cafe_rooms/oasis
	name = "Oasis"
	mappath = "modular_skyrat/modules/hotel_rooms/oasis.dmm"

/datum/map_template/ghost_cafe_rooms/oasisalt
	name = "Oasis (Night)"
	mappath = "modular_skyrat/modules/hotel_rooms/oasisalt.dmm"
