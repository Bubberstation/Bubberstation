// Persistance Areas - Lavaland

/area/ruin/space/has_grav/bubbers/persistance
	name = "SSV Persistence"
	icon = 'icons/area/areas_centcom.dmi'
	icon_state = "syndie-ship"
	outdoors = FALSE
	ignore_weather_sfx = TRUE
	flags_1 = parent_type::flags_1 & ~(CAN_BE_DIRTY_1) // Stops SSDecay from affecting the Persistance

// Cargo

/area/ruin/space/has_grav/bubbers/persistance/cargo
	name = "Persistence Hangarbay"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/cargo/dispoals
	name = "Persistence Dispoals System"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/cargo/drone
	name = "Persistence Long Range Monitoring and Drone Deployment"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/cargo/mining
	name = "Persistance Mining Equipment Room"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

// Engineering

/area/ruin/space/has_grav/bubbers/persistance/engineering
	name = "Persistence Engineering Bay"

/area/ruin/space/has_grav/bubbers/persistance/engineering/atmospherics
	name = "Persistence Atmospherics Room"

/area/ruin/space/has_grav/bubbers/persistance/engineering/mining
	name = "Persistence Bluespace Mining"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/engineering/gas
	name = "Persistence Gas Harvesting and Storage"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/engineering/utilities
	name = "Persistence Utilities System"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

// Service - Recreation

/area/ruin/space/has_grav/bubbers/persistance/service
	name = "Main Hall"

/area/ruin/space/has_grav/bubbers/persistance/evac
	name = "Persistence Evacuation Capsule Bay"

/area/ruin/space/has_grav/bubbers/persistance/service/diner
	name = "Persistence Diner"
	mood_bonus = 3
	mood_message = "I love being in the diner!"

/area/ruin/space/has_grav/bubbers/persistance/service/kitchen
	name = "Persistence Kitchen"

/area/ruin/space/has_grav/bubbers/persistance/service/freezer
	name = "Persistence Kitchen Freezer"

/area/ruin/space/has_grav/bubbers/persistance/service/hydro
	name = "Persistence Hydroponics"

/area/ruin/space/has_grav/bubbers/persistance/service/shower
	name = "Persistence Crew Showers"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/service/lockers
	name = "Persistence Locker Room"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/service/gym
	name = "Persistence Gym"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/lounge
	name = "Persistence Lounge"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
	mood_bonus = 5
	mood_message = "I feel at ease here."

/area/ruin/space/has_grav/bubbers/persistance/service/janitorial
	name = "Persistence Janitor Storage"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/salon
	name = "Persistence Salon"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/sauna
	name = "Persistence Sauna"
	mood_bonus = 5
	mood_message = "This place is quite relaxing."
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

//dorms
/area/ruin/space/has_grav/bubbers/persistance/service/dorms
	name = "Persistence Dormitories"
	mood_bonus = 5
	mood_message = "I feel at ease here."
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/engineering
	name = "Persistence Engineering Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/science
	name = "Persistence Researcher Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/chef
	name = "Persistence Bartender Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/janitor
	name = "Persistence Sanitation Technician Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/cargo
	name = "Persistence Quarter Master Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/liason
	name = "Persistence Corporate Liason Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/assistant
	name = "Persistence Assistant"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/morale
	name = "Persistence Morale Officer Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/maa
	name = "Persistence Master At Arms Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/brig
	name = "Persistence Brig Officer Quarters"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/medical
	name = "Persistence Medical Officer Quarters"

// Science

/area/ruin/space/has_grav/bubbers/persistance/sci
	name = "Persistence Science"

/area/ruin/space/has_grav/bubbers/persistance/sci/rnd
	name = "Persistence Experimentation Lab"

/area/ruin/space/has_grav/bubbers/persistance/sci/robotics
	name = "Persistence Robotics Lab"

/area/ruin/space/has_grav/bubbers/persistance/sci/ordnance
	name = "Persistence Ordnance Lab"

/area/ruin/space/has_grav/bubbers/persistance/sci/xenobio
	name = "Persistence Xenobiology Lab"

/area/ruin/space/has_grav/bubbers/persistance/sci/xenoarchology
	name = "Persistence Archology Lab"

// Medical

/area/ruin/space/has_grav/bubbers/persistance/med
	name = "Persistence Medical"

/area/ruin/space/has_grav/bubbers/persistance/med/treatment
	name = "Persistence Treatment Bay"

/area/ruin/space/has_grav/bubbers/persistance/med/storage
	name = "Persistence Medical Storage"

/area/ruin/space/has_grav/bubbers/persistance/med/chem
	name = "Persistence Chemistry Lab"

/area/ruin/space/has_grav/bubbers/persistance/med/viro
	name = "Persistence Virology Lab"

/area/ruin/space/has_grav/bubbers/persistance/command
	name = "Persistence Command"

/area/ruin/space/has_grav/bubbers/persistance/command/bridge
	name = "Persistence Bridge"

/area/ruin/space/has_grav/bubbers/persistance/command/admiral
	name = "Persistence Office"

/area/ruin/space/has_grav/bubbers/persistance/command/liason
	name = "Corporate Liason Office"

/area/ruin/space/has_grav/bubbers/persistance/command/vault
	name = "High Security Vault"

/area/ruin/space/has_grav/bubbers/persistance/command/maa
	name = "Master At Arms Office"

//Security - Prison

/area/ruin/space/has_grav/bubbers/persistance/sec
	name = "Persistence Security"

/area/ruin/space/has_grav/bubbers/persistance/sec/brigentrance
	name = "Persistence Brig Desk and Cell"

/area/ruin/space/has_grav/bubbers/persistance/sec/holding
	name = "Holding Cells"

/area/ruin/space/has_grav/bubbers/persistance/sec/armory
	name = "Persistence Armory"

/area/ruin/space/has_grav/bubbers/persistance/sec/interrogation
	name = "Interrogation and Solutions"

/area/ruin/space/has_grav/bubbers/persistance/sec/prison // Prison
	name = "Persistence General Population"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/sec/prison/holding
	name = "Isolation Cell"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/sec/prison/rec
	name = "Prisoner Privlages Room"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/sec/prison/shower
	name = "Prison Showers"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/datum/weather/rad_storm/New()
	. = ..()
	protected_areas += /area/ruin/space/has_grav/bubbers/persistance
