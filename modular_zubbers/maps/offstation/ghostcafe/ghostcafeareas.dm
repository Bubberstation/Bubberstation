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
	icon_state = "graveyard"
	icon = 'icons/area/areas_station.dmi'

/area/centcom/holding/cafe/station/service
	name = "\improper Ghost Cafe Service"
	icon_state = "kitchen"
	airlock_wires = /datum/wires/airlock/service

/area/centcom/holding/cafe/station/service/kitchen
	name = "\improper Ghost Cafe Kitchen"
	icon_state = "kitchen"

/area/centcom/holding/cafe/station/commons/toilet/shower
	name = "\improper Ghost Cafe Shower Room"
	icon_state = "shower"

/area/centcom/holding/cafe/station/commons/toilet //skibidi
	name = "\improper Ghost Cafe Toilets"
	icon_state = "toilet"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/centcom/holding/cafe/station/service/kitchen/coldroom
	name = "\improper Ghost Cafe Kitchen Cold Room"
	icon_state = "kitchen_cold"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
	ambience_index = AMBIENCE_SPOOKY

/area/centcom/holding/cafe/station/commons/lounge
	name = "\improper Ghost Cafe Bar Lounge"
	icon_state = "lounge"
	mood_bonus = 5
	mood_message = "I love being in the bar!"
	mood_trait = TRAIT_EXTROVERT
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/centcom/holding/cafe/station/service/hydroponics
	name = "Ghost Cafe Hydroponics"
	icon_state = "hydro"
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/commons/fitness
	name = "\improper Ghost Cafe Leather Club"
	icon_state = "fitness"

/area/centcom/holding/cafe/station/commons/fitness/locker_room
	name = "\improper Ghost Cafe Unisex Locker Room"
	icon_state = "locker"

/area/centcom/holding/cafe/station/commons/fitness/recreation/sauna
	name = "\improper Ghost Cafe Sauna"
	icon_state = "sauna"

/area/centcom/holding/cafe/station/service/janitor
	name = "Ghost Cafe Janitorial Room"
	icon_state = "janitor"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/centcom/holding/cafe/station/service/lawoffice
	name = "\improper Ghost Cafe Law Office"
	icon_state = "law"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/centcom/holding/cafe/station/service/barber
	name = "\improper Ghost Cafe Barber"
	icon_state = "barber"

/area/centcom/holding/cafe/station/commons/kiosk
	name = "Ghost Cafe Kiosk"
	icon_state = "commons"

/area/centcom/holding/cafe/station/medical
	name = "Ghost Cafe Medical"
	icon_state = "medbay"
	ambience_index = AMBIENCE_MEDICAL
	airlock_wires = /datum/wires/airlock/medbay
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/medical/psychology
	name = "\improper Ghost Cafe Psychology Office"
	icon_state = "psychology"
	mood_bonus = 3
	mood_message = "I feel at ease here."
	ambientsounds = list(
		'sound/ambience/aurora_caelus/aurora_caelus_short.ogg',
		)

/area/centcom/holding/cafe/station/medical/cryo
	name = "Cryogenics"
	icon_state = "cryo"

/area/centcom/holding/cafe/station/science/robotics/augments
	name = "\improper Ghost Cafe Robotics"
	icon_state = "robotics"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/centcom/holding/cafe/station/command
	name = "Ghost Cafe Command"
	icon_state = "command"
	ambientsounds = list(
		'sound/ambience/misc/signal.ogg',
		)
	airlock_wires = /datum/wires/airlock/command
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/command/meeting_room
	name = "\improper Ghost Cafe Heads of Staff Meeting Room"
	icon_state = "meeting"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/centcom/holding/cafe/station/command/cap
	name = "Ghost Cafe Captain's Office"
	icon_state = "captain"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/centcom/holding/cafe/station/command/cap/private
	name = "Ghost Cafe Captain's Chamber"
	icon_state = "captain_private"

/area/centcom/holding/cafe/station/command/teleporter
	name = "\improper Ghost Cafe Teleporter"
	icon_state = "teleporter"
	ambience_index = AMBIENCE_ENGI

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

/area/centcom/holding/cafe/station/service/library
	name = "\improper Ghost Cafe Library"
	icon_state = "library"
	mood_bonus = 5
	mood_message = "I love being in the library!"
	mood_trait = TRAIT_INTROVERT
	sound_environment = SOUND_AREA_LARGE_SOFTFLOOR

/area/centcom/holding/cafe/station/engineering
	name = "Ghost Cafe Engineering"
	icon_state = "engie"
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/centcom/holding/cafe/ruin
	icon = 'icons/area/areas_ruins.dmi'

/area/centcom/holding/cafe/ruin/caves
	name = "Ghost Cafe Caves"
	icon_state = "os_beta_mining"
	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_ENVIRONMENT_CAVE

/area/centcom/holding/cafe/ruin/ash_walkers
	name = "Ghost Cafe Ash Walker Nest"
	icon_state = "os_beta_mining"
	ambience_index = AMBIENCE_MINING
	sound_environment = SOUND_AREA_LAVALAND
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'

/area/centcom/holding/cafe/ruin/icemoon
	name = "Ghost Cafe Snow"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'

/area/centcom/holding/cafe/ruin/xenonest
	name = "Ghost Cafe Xenomorph Nest"
	icon_state = "os_delta_hall"
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

