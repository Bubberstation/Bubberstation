/**********************Taeloth Areas**************************/

/area/taeloth
	name = "Taeloth"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_TAELOTH
	ambience_index = AMBIENCE_HOLY
	min_ambience_cooldown = 4 MINUTES
	max_ambience_cooldown = 8 MINUTES
	outdoors = TRUE
	ambient_buzz = 'local/sound/ambience/buzz/jungleloop.ogg'

/area/taeloth/Initialize(mapload)
	try_lighting()
	return ..()

/area/taeloth/proc/try_lighting()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_BRIGHT_DAY))
		base_lighting_alpha = 125 // With all that canopy in the way and no snow to amplify, things are a smidge darker than Icebox.

/*
	SURFACE FEATURES
*/

/area/taeloth/hotspring
	name = "Taeloth - Hotspring"
	ambientsounds = list('local/sound/ambience/ambihotspring.ogg')
	mood_bonus = 10
	mood_message = "I feel relaxed and refreshed!"
	min_ambience_cooldown = 2 MINUTES
	max_ambience_cooldown = 4 MINUTES

/area/taeloth/ocean
	name = "Taeloth - Ocean"
	ambientsounds = /area/awaymission/beach::ambientsounds

/*
	STATION CHUNKS
*/

/// 'nearstation' sections mimic how hallways work on a traditional ss13 map; so blob is allowed to both move through it and place here freely. not sure why you would; but still
/// likewise cult can also build/rune here. again - probably not smart as a cultie; but you can. There are some exceptions to areas we want to name but don't want either on; too.
/// For those; see /area/taeloth/nearstation/no_valids_to_hunt
/area/taeloth/nearstation
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED | UNIQUE_AREA | FLORA_ALLOWED | CULT_PERMITTED

/// AI
/area/taeloth/nearstation/ai_sat_trail
	name = "AI Satellite Trail"
	icon_state = "ai_foyer"

/// ARRIVALS
/area/taeloth/nearstation/arrivals
	name = "Arrivals Crossway"
	icon_state = "entry"

/area/taeloth/nearstation/public_mining_dock_roof
	name = "Public Mining Dock - Roof"
	icon_state = "mining_dock"

/// CARGO
/area/taeloth/nearstation/cargo_crossway
	name = "Cargo Crossway"
	icon_state = "cargo_lobby"

/area/taeloth/nearstation/cargo_crossway/pavement
	name = "Cargo Department - Exterior"
	icon_state = "cargo_lobby"

/area/taeloth/nearstation/cargo_roof
	name = "Cargo - Roof"
	icon_state = "cargo_lobby"

/// COMMAND
/area/taeloth/nearstation/bridge_roof
	name = "Bridge - Roof"
	icon_state = "bridge"

/area/taeloth/nearstation/bridge_roof/patio
	name = "Bridge - Patio"

/area/taeloth/nearstation/bridge_roof/patio/under
	name = "Bridge - Patio Underside"

/area/taeloth/nearstation/bridge_crossway
	name = "Bridge Crossway"
	icon_state = "bridge_hallway"

/area/taeloth/nearstation/bridge_crossway/deck
	name = "Bridge - Deck"
	icon_state = "bridge_hallway"

/area/taeloth/nearstation/gateway
	name = "Gateway Crossway"
	icon_state = "gateway"

/area/taeloth/nearstation/gateway/roof
	name = "Gateway - Roof"

/// DORMS

/area/taeloth/nearstation/dormitory_concourse
	name = "Dormitory Concourse"
	icon_state = "dorms"

/area/taeloth/nearstation/dormitory_concourse/ferry_dock_beach
	name = "Ferry Dock - Beach"
	ambientsounds = /area/awaymission/beach::ambientsounds

/area/taeloth/nearstation/dormitory_concourse/sinners_trail
	name = "Dormitory Concourse - Sinner's Trail"

/area/taeloth/nearstation/dormitory_concourse/crew_facilities
	name = "Dormitory Concourse - Crew Facilities"
	icon_state = "commons"

/area/taeloth/nearstation/dormitory_concourse/crew_facilities/roof
	name = "Crew Facilities - Roof"

/// ENGINEERING
/area/taeloth/nearstation/engsci_crossway
	name = "Engineer-Science Crossway"
	icon_state = "engie"

/// MEDICAL
/area/taeloth/nearstation/medsci_crossway
	name = "Medical-Science Crossway"
	icon_state = "science_lobby"

/area/taeloth/nearstation/medical_roof
	name = "Medical - Roof"
	icon_state = "medbay"

/area/taeloth/nearstation/medical_roof/garden
	name = "Medical - Rooftop Garden"

/area/taeloth/nearstation/virology_pen
	name = "Virology - Monkey Pen"
	icon_state = "virology"

/// PUBLIC
/area/taeloth/nearstation/departures_deck
	name = "Departures Deck"
	icon_state = "escape_lounge"

/area/taeloth/nearstation/restroom_crossway
	name = "Restroom Crossway"
	icon_state = "restrooms"

/area/taeloth/nearstation/restroom_roof
	name = "Restrooms - Roof"
	icon_state = "restrooms"

/// SCIENCE
/area/taeloth/nearstation/science_roof
	name = "Science - Roof"
	icon_state = "science"

/// SECURITY
/area/taeloth/nearstation/medsec_crossway
	name = "Medical-Security Crossway"
	icon_state = "checkpoint_arr"

/area/taeloth/nearstation/security_roof
	name = "Security - Roof"
	icon_state = "checkpoint_arr"

/// SERVICE
/area/taeloth/nearstation/service_crossway
	name = "Service Crossway - North"
	icon_state = "hall_service"

/area/taeloth/nearstation/service_crossway/south
	name = "Service Crossway - South"

/area/taeloth/nearstation/service_crossway/bar
	name = "Bar Crossway - North"
	icon_state = "bar"

/area/taeloth/nearstation/service_crossway/public_garden
	name = "Exterior - Public Garden"

/area/taeloth/nearstation/service_roof
	name = "Service - Roof"
	icon_state = "hall_service"


/*
	Blob-Banned; Cult-Banned
*/

/area/taeloth/nearstation/no_valids_to_hunt
	area_flags = /area/taeloth::area_flags

/// AI
/area/taeloth/nearstation/no_valids_to_hunt/ai_sat_lake
	name = "AI Satellite - Lake"
	icon_state = "ai"

/// ARRIVALS
/area/taeloth/nearstation/no_valids_to_hunt/arrivals_landing_zone
	name = "Arrivals - Landing Zone"
	icon_state = "entry"

/area/taeloth/nearstation/no_valids_to_hunt/arrivals_landing_zone/public_mining
	name = "Public Mining Landing Zone"

/// CARGO
/area/taeloth/nearstation/no_valids_to_hunt/cargo_landing_zone
	name = "Cargo Shuttle Landing Zone"
	icon_state = "cargo_bay"

/area/taeloth/nearstation/no_valids_to_hunt/cargo_landing_zone/mining
	name = "Mining Shuttle Landing Zone"
	icon_state = "mining_dock"

/// COMMAND
/area/taeloth/nearstation/no_valids_to_hunt/bridge_lake
	name = "Central Lake"
	icon_state = "centralhall"

/// PUBLIC
/area/taeloth/nearstation/no_valids_to_hunt/departures_landing_zone
	name = "Departures Landing Zone"
	icon_state = "escape"

/*
	GENERATED CHUNKS
*/

/area/taeloth/unexplored // In theory, monsters spawn here. They do not in practice, unimplemented. Random Generation + Ruins work though.
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/jungle_generator
	mood_bonus = -5
	mood_message = "The trees themselves feel like walls; closing in..." // Makes it harder to stay out in the jungle over a prolonged period of time.

/area/taeloth/unexplored/danger // Additional to said theory: megafauna.
	icon_state = "danger"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED

/*
	UNGERGROUND
*/

/area/taeloth/underground
	name = "Taeloth Caves"
	mood_bonus = -5
	mood_message = "It doesn't feel safe, being down here..." // Makes it harder to stay in the caves over a prolonged period of time. Done for non-generated sections too; unlike the exteriors!
	ambient_buzz = 'local/sound/ambience/buzz/caveloop.ogg'

/area/taeloth/underground/try_lighting()
	return

/area/taeloth/underground/unexplored
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/rimpoint_jungle // really need to replace that floor with a proper stone one at some point.. soon(tm)
