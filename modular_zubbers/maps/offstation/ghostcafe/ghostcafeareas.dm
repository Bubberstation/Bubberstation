/*
* Ghost Cafe
*/

/area/centcom/holding
	name = "Holding Facility"
	mood_bonus = 25
	area_flags = parent_type::area_flags | UNLIMITED_FISHING
	mood_message = "I am taking a well deserved rest!"

/area/centcom/holding/cafe
	name = "Ghost Cafe"

/area/centcom/holding/cafe/vox
	name = "Cafe Vox Box"

/area/centcom/holding/cafe/dorms
	name = "Ghost Cafe Dorms"

/area/centcom/holding/cafe/park
	name = "Ghost Cafe Outdoors"

/area/centcom/holding/cafe/station
	icon = 'icons/area/areas_station.dmi'

/area/centcom/holding/cafe/station/kitchen/coldroom
	name = "\improper Ghost Cafe Kitchen Cold Room"
	icon_state = "kitchen_cold"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
	ambience_index = AMBIENCE_SPOOKY

/area/centcom/holding/cafe/station/med
	name = "Ghost Cafe Medical"
	icon_state = "medbay"
	ambience_index = AMBIENCE_MEDICAL
	airlock_wires = /datum/wires/airlock/medbay
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/command
	name = "Ghost Cafe Command"
	icon_state = "command"
	ambientsounds = list(
		'sound/ambience/misc/signal.ogg',
		)
	airlock_wires = /datum/wires/airlock/command
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/command/cap
	name = "Ghost Cafe Captain's Office"
	icon_state = "captain"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/centcom/holding/cafe/station/maint
	name = "Ghost Cafe Maintenance"
	icon_state = "maint_electrical"
	ambience_index = AMBIENCE_MAINT
	airlock_wires = /datum/wires/airlock/maint
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED
	forced_ambience = TRUE
	ambient_buzz = 'sound/ambience/maintenance/source_corridor2.ogg'
	ambient_buzz_vol = 20

/area/centcom/holding/cafe/station/security
	name = "Ghost Cafe Security"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/library
	name = "\improper Ghost Cafe Library"
	icon_state = "library"
	mood_bonus = 5
	mood_message = "I love being in the library!"
	mood_trait = TRAIT_INTROVERT
	sound_environment = SOUND_AREA_LARGE_SOFTFLOOR

/area/centcom/holding/cafe/icemoon
	name = "Ghost Cafe Snow"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'


/area/centcom/holding/cafe/ash_walkers
	name = "Ghost Cafe Walker Nest"
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'

/area/centcom/holding/cafe/xenonest
	name = "Ghost Cafe Xenomorph Nest"
	ambience_index = AMBIENCE_SPOOKY

/area/centcom/holding/cafe/beach
	name = "Ghost Cafe Beach"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away"
	ambientsounds = list('sound/ambience/beach/shore.ogg', 'sound/ambience/beach/seag1.ogg','sound/ambience/beach/seag2.ogg','sound/ambience/beach/seag3.ogg','sound/ambience/misc/ambiodd.ogg','sound/ambience/medical/ambinice.ogg')

//Interlink

/area/centcom/interlink
	name = "The Interlink"

/area/centcom/interlink/dorm_rooms
	name = "Interlink Dorm Rooms"
	mood_bonus = /area/centcom/holding::mood_bonus
	mood_message = /area/centcom/holding::mood_message

