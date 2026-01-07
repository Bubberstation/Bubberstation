//Modular file for away mission areas that won't conflict with station areas, for use in the Build Your Own Station event then to be deleted once the map is finalized
/area/awaymission/station
	name = "Station Areas"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "station"

//CARGO
/area/awaymission/station/cargo
	name = "Quartermasters"
	icon_state = "quart"
	airlock_wires = /datum/wires/airlock/cargo
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/cargo/sorting
	name = "\improper Delivery Office"
	icon_state = "cargo_delivery"

/area/awaymission/station/cargo/warehouse
	name = "\improper Warehouse"
	icon_state = "cargo_warehouse"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/cargo/drone_bay
	name = "\improper Drone Bay"
	icon_state = "cargo_drone"

/area/awaymission/station/cargo/boutique
	name = "\improper Boutique"
	icon_state = "cargo_delivery"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/cargo/warehouse/upper
	name = "\improper Upper Warehouse"

/area/awaymission/station/cargo/office
	name = "\improper Cargo Office"
	icon_state = "cargo_office"

/area/awaymission/station/cargo/lower
	name = "\improper Lower Cargo Bay"
	icon_state = "lower_cargo"

/area/awaymission/station/cargo/breakroom
	name = "\improper Cargo Break Room"
	icon_state = "cargo_breakroom"

/area/awaymission/station/cargo/storage
	name = "\improper Cargo Bay"
	icon_state = "cargo_bay"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/cargo/lobby
	name = "\improper Cargo Lobby"
	icon_state = "cargo_lobby"

/area/awaymission/station/cargo/miningdock
	name = "\improper Mining Dock"
	icon_state = "mining_dock"

/area/awaymission/station/cargo/miningdock/cafeteria
	name = "\improper Mining Cafeteria"
	icon_state = "mining_cafe"

/area/awaymission/station/cargo/miningdock/oresilo
	name = "\improper Mining Ore Silo Storage"
	icon_state = "mining_silo"

/area/awaymission/station/cargo/miningoffice
	name = "\improper Mining Office"
	icon_state = "mining"

/area/awaymission/station/cargo/mining_breakroom
	name = "\improper Mining Break Room"
	icon_state = "mining_breakroom"

/area/awaymission/station/cargo/miningfoundry
	name = "\improper Mining Foundry"
	icon_state = "mining_foundry"

/area/awaymission/station/cargo/blacksmith
	name = "\improper Blacksmith Workshop"
	icon_state = "cargo_warehouse"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

//COMMAND
/area/awaymission/station/command
	name = "Command"
	icon_state = "command"
	ambientsounds = list(
		'sound/ambience/misc/signal.ogg',
		)
	airlock_wires = /datum/wires/airlock/command
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/command/bridge
	name = "\improper Bridge"
	icon_state = "bridge"

/area/awaymission/station/command/meeting_room
	name = "\improper Heads of Staff Meeting Room"
	icon_state = "meeting"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/awaymission/station/command/meeting_room/council
	name = "\improper Council Chamber"
	icon_state = "meeting"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/awaymission/station/command/corporate_showroom
	name = "\improper Corporate Showroom"
	icon_state = "showroom"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/awaymission/station/command/corporate_suite
	name = "\improper Corporate Guest Suite"
	icon_state = "command"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/command/emergency_closet
	name = "\improper Corporate Emergency Closet"
	icon_state = "command"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/command/heads_quarters
	icon_state = "heads_quarters"

/area/awaymission/station/command/heads_quarters/captain
	name = "\improper Captain's Office"
	icon_state = "captain"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/command/heads_quarters/captain/private
	name = "\improper Captain's Quarters"
	icon_state = "captain_private"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/command/heads_quarters/ce
	name = "\improper Chief Engineer's Office"
	icon_state = "ce_office"

/area/awaymission/station/command/heads_quarters/cmo
	name = "\improper Chief Medical Officer's Office"
	icon_state = "cmo_office"

/area/awaymission/station/command/heads_quarters/hop
	name = "\improper Head of Personnel's Office"
	icon_state = "hop_office"

/area/awaymission/station/command/heads_quarters/hos
	name = "\improper Head of Security's Office"
	icon_state = "hos_office"

/area/awaymission/station/command/heads_quarters/rd
	name = "\improper Research Director's Office"
	icon_state = "rd_office"

/area/awaymission/station/command/heads_quarters/qm
	name = "\improper Quartermaster's Office"
	icon_state = "qm_office"

/area/awaymission/station/command/teleporter
	name = "\improper Teleporter Room"
	icon_state = "teleporter"
	ambience_index = AMBIENCE_ENGI

/area/awaymission/station/command/gateway
	name = "\improper Gateway"
	icon_state = "gateway"
	ambience_index = AMBIENCE_ENGI

/area/awaymission/station/command/corporate_dock
	name = "\improper Corporate Private Dock"
	icon_state = "command"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

//COMMON AREAS
/area/awaymission/station/commons
	name = "\improper Crew Facilities"
	icon_state = "commons"
	sound_environment = SOUND_AREA_STANDARD_STATION
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

/area/awaymission/station/commons/dorms
	name = "\improper Dormitories"
	icon_state = "dorms"

/area/awaymission/station/commons/dorms/room1
	name = "\improper Dorms Room 1"
	icon_state = "room1"

/area/awaymission/station/commons/dorms/room2
	name = "\improper Dorms Room 2"
	icon_state = "room2"

/area/awaymission/station/commons/dorms/room3
	name = "\improper Dorms Room 3"
	icon_state = "room3"

/area/awaymission/station/commons/dorms/room4
	name = "\improper Dorms Room 4"
	icon_state = "room4"

/area/awaymission/station/commons/dorms/apartment1
	name = "\improper Dorms Apartment 1"
	icon_state = "apartment1"

/area/awaymission/station/commons/dorms/apartment2
	name = "\improper Dorms Apartment 2"
	icon_state = "apartment2"

/area/awaymission/station/commons/dorms/barracks
	name = "\improper Sleep Barracks"

/area/awaymission/station/commons/dorms/barracks/male
	name = "\improper Male Sleep Barracks"
	icon_state = "dorms_male"

/area/awaymission/station/commons/dorms/barracks/female
	name = "\improper Female Sleep Barracks"
	icon_state = "dorms_female"

/area/awaymission/station/commons/dorms/laundry
	name = "\improper Laundry Room"
	icon_state = "laundry_room"

/area/awaymission/station/commons/toilet
	name = "\improper Dormitory Toilets"
	icon_state = "toilet"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/commons/toilet/auxiliary
	name = "\improper Auxiliary Restrooms"
	icon_state = "toilet"

/area/awaymission/station/commons/toilet/locker
	name = "\improper Locker Toilets"
	icon_state = "toilet"

/area/awaymission/station/commons/toilet/restrooms
	name = "\improper Restrooms"
	icon_state = "toilet"

/area/awaymission/station/commons/toilet/shower
	name = "\improper Shower Room"
	icon_state = "shower"

/area/awaymission/station/commons/locker
	name = "\improper Locker Room"
	icon_state = "locker"

/area/awaymission/station/commons/lounge
	name = "\improper Bar Lounge"
	icon_state = "lounge"
	mood_bonus = 5
	mood_message = "I love being in the bar!"
	mood_trait = TRAIT_EXTROVERT
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/commons/fitness
	name = "\improper Fitness Room"
	icon_state = "fitness"

/area/awaymission/station/commons/fitness/locker_room
	name = "\improper Unisex Locker Room"
	icon_state = "locker"

/area/awaymission/station/commons/fitness/locker_room/male
	name = "\improper Male Locker Room"
	icon_state = "locker_male"

/area/awaymission/station/commons/fitness/locker_room/female
	name = "\improper Female Locker Room"
	icon_state = "locker_female"

/area/awaymission/station/commons/fitness/recreation
	name = "\improper Recreation Area"
	icon_state = "rec"

/area/awaymission/station/commons/fitness/recreation/entertainment
	name = "\improper Entertainment Center"
	icon_state = "entertainment"

/area/awaymission/station/commons/fitness/recreation/pool
	name = "\improper Swimming Pool"
	icon_state = "pool"

/area/awaymission/station/commons/fitness/recreation/lasertag
	name = "\improper Laser Tag Arena"
	icon_state = "lasertag"

/area/awaymission/station/commons/fitness/recreation/sauna
	name = "\improper Sauna"
	icon_state = "sauna"

/area/awaymission/station/commons/vacant_room
	name = "\improper Vacant Room"
	icon_state = "vacant_room"
	ambience_index = AMBIENCE_MAINT

/area/awaymission/station/commons/vacant_room/office
	name = "\improper Vacant Office"
	icon_state = "vacant_office"

/area/awaymission/station/commons/vacant_room/commissary
	name = "\improper Vacant Commissary"
	icon_state = "vacant_commissary"

/area/awaymission/station/commons/storage
	name = "\improper Commons Storage"

/area/awaymission/station/commons/storage/tools
	name = "\improper Auxiliary Tool Storage"
	icon_state = "tool_storage"

/area/awaymission/station/commons/storage/primary
	name = "\improper Primary Tool Storage"
	icon_state = "primary_storage"

/area/awaymission/station/commons/storage/art
	name = "\improper Art Supply Storage"
	icon_state = "art_storage"

/area/awaymission/station/commons/storage/emergency/starboard
	name = "\improper Starboard Emergency Storage"
	icon_state = "emergency_storage"

/area/awaymission/station/commons/storage/emergency/port
	name = "\improper Port Emergency Storage"
	icon_state = "emergency_storage"

/area/awaymission/station/commons/storage/mining
	name = "\improper Public Mining Storage"
	icon_state = "mining_storage"

/area/awaymission/station/commons/dock
	name = "\improper Station Ship Dock"
	icon_state = "hallFS"

/area/awaymission/station/commons/dock/aux
	name = "\improper Auxiliary Ship Dock"
	icon_state = "hallAP"

/area/awaymission/station/commons/dock/secondary
	name = "\improper Secondary Ship Dock"
	icon_state = "hallAS"

//ENGINEERING
/area/awaymission/station/engineering
	icon_state = "engie"
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/engineering/engine_smes
	name = "\improper Engineering SMES"
	icon_state = "engine_smes"

/area/awaymission/station/engineering/main
	name = "Engineering"
	icon_state = "engine"

/area/awaymission/station/engineering/hallway
	name = "Engineering Hallway"
	icon_state = "engine_hallway"

/area/awaymission/station/engineering/atmos
	name = "Atmospherics"
	icon_state = "atmos"

/area/awaymission/station/engineering/atmos/upper
	name = "Upper Atmospherics"

/area/awaymission/station/engineering/atmos/space_catwalk
	name = "\improper Atmospherics Space Catwalk"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

	sound_environment = SOUND_AREA_SPACE
	ambience_index = AMBIENCE_SPACE
	ambient_buzz = null //Space is deafeningly quiet
	min_ambience_cooldown = 195 SECONDS //length of ambispace.ogg
	max_ambience_cooldown = 200 SECONDS

/area/awaymission/station/engineering/atmos/project
	name = "\improper Atmospherics Project Room"
	icon_state = "atmos_projectroom"

/area/awaymission/station/engineering/atmos/pumproom
	name = "\improper Atmospherics Pumping Room"
	icon_state = "atmos_pump_room"

/area/awaymission/station/engineering/atmos/mix
	name = "\improper Atmospherics Mixing Room"
	icon_state = "atmos_mix"

/area/awaymission/station/engineering/atmos/storage
	name = "\improper Atmospherics Storage Room"
	icon_state = "atmos_storage"

/area/awaymission/station/engineering/atmos/storage/gas
	name = "\improper Atmospherics Gas Storage"
	icon_state = "atmos_storage_gas"

/area/awaymission/station/engineering/atmos/office
	name = "\improper Atmospherics Office"
	icon_state = "atmos_office"

/area/awaymission/station/engineering/atmos/hfr_room
	name = "\improper Atmospherics HFR Room"
	icon_state = "atmos_HFR"

/area/awaymission/station/engineering/atmospherics_engine
	name = "\improper Atmospherics Engine"
	icon_state = "atmos_engine"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

/area/awaymission/station/engineering/lobby
	name = "\improper Engineering Lobby"
	icon_state = "engi_lobby"

/area/awaymission/station/engineering/supermatter
	name = "\improper Supermatter Engine"
	icon_state = "engine_sm"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/engineering/supermatter/waste
	name = "\improper Supermatter Waste Chamber"
	icon_state = "engine_sm_waste"

/area/awaymission/station/engineering/supermatter/room
	name = "\improper Supermatter Engine Room"
	icon_state = "engine_sm_room"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/engineering/supermatter/room/upper
	name = "\improper Upper Supermatter Engine Room"
	icon_state = "engine_sm_room_upper"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/engineering/break_room
	name = "\improper Engineering Foyer"
	icon_state = "engine_break"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/engineering/gravity_generator
	name = "\improper Gravity Generator Room"
	icon_state = "grav_gen"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/engineering/storage
	name = "Engineering Storage"
	icon_state = "engine_storage"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/engineering/storage_shared
	name = "Shared Engineering Storage"
	icon_state = "engine_storage_shared"

/area/awaymission/station/engineering/transit_tube
	name = "\improper Transit Tube"
	icon_state = "transit_tube"

/area/awaymission/station/engineering/storage/tech
	name = "Technical Storage"
	icon_state = "tech_storage"

/area/awaymission/station/engineering/storage/tcomms
	name = "Telecomms Storage"
	icon_state = "tcom_storage"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

/area/awaymission/station/construction
	name = "\improper Construction Area"
	icon_state = "construction"
	ambience_index = AMBIENCE_ENGI
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/construction/mining/aux_base
	name = "Auxiliary Base Construction"
	icon_state = "aux_base_construction"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/awaymission/station/construction/storage_wing
	name = "\improper Storage Wing"
	icon_state = "storage_wing"

//HALLWAYS
/area/awaymission/station/hallway
	icon_state = "hall"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/hallway/primary
	name = "\improper Primary Hallway"
	icon_state = "primaryhall"

/area/awaymission/station/hallway/primary/aft
	name = "\improper Aft Primary Hallway"
	icon_state = "afthall"

/area/awaymission/station/hallway/primary/fore
	name = "\improper Fore Primary Hallway"
	icon_state = "forehall"

/area/awaymission/station/hallway/primary/starboard
	name = "\improper Starboard Primary Hallway"
	icon_state = "starboardhall"

/area/awaymission/station/hallway/primary/port
	name = "\improper Port Primary Hallway"
	icon_state = "porthall"

/area/awaymission/station/hallway/primary/central
	name = "\improper Central Primary Hallway"
	icon_state = "centralhall"

/area/awaymission/station/hallway/primary/central/fore
	name = "\improper Fore Central Primary Hallway"
	icon_state = "hallCF"

/area/awaymission/station/hallway/primary/central/aft
	name = "\improper Aft Central Primary Hallway"
	icon_state = "hallCA"

/area/awaymission/station/hallway/primary/upper
	name = "\improper Upper Central Primary Hallway"
	icon_state = "centralhall"

/area/awaymission/station/hallway/primary/tram
	name = "\improper Primary Tram"

/area/awaymission/station/hallway/primary/tram/left
	name = "\improper Port Tram Dock"
	icon_state = "halltramL"

/area/awaymission/station/hallway/primary/tram/center
	name = "\improper Central Tram Dock"
	icon_state = "halltramM"

/area/awaymission/station/hallway/primary/tram/right
	name = "\improper Starboard Tram Dock"
	icon_state = "halltramR"

/area/awaymission/station/hallway/secondary
	icon_state = "secondaryhall"

/area/awaymission/station/hallway/secondary/command
	name = "\improper Command Hallway"
	icon_state = "bridge_hallway"

/area/awaymission/station/hallway/secondary/construction
	name = "\improper Construction Area"
	icon_state = "construction"

/area/awaymission/station/hallway/secondary/construction/engineering
	name = "\improper Engineering Hallway"

/area/awaymission/station/hallway/secondary/exit
	name = "\improper Escape Shuttle Hallway"
	icon_state = "escape"

/area/awaymission/station/hallway/secondary/exit/escape_pod
	name = "\improper Escape Pod Bay"
	icon_state = "escape_pods"

/area/awaymission/station/hallway/secondary/exit/departure_lounge
	name = "\improper Departure Lounge"
	icon_state = "escape_lounge"

/area/awaymission/station/hallway/secondary/entry
	name = "\improper Arrival Shuttle Hallway"
	icon_state = "entry"
	area_flags = EVENT_PROTECTED

/area/awaymission/station/hallway/secondary/dock
	name = "\improper Secondary Station Dock Hallway"
	icon_state = "hall"

/area/awaymission/station/hallway/secondary/service
	name = "\improper Service Hallway"
	icon_state = "hall_service"

/area/awaymission/station/hallway/secondary/spacebridge
	name = "\improper Space Bridge"
	icon_state = "hall"

/area/awaymission/station/hallway/secondary/recreation
	name = "\improper Recreation Hallway"
	icon_state = "hall"

/area/awaymission/station/hallway/floor1
	name = "\improper First Floor Hallway"

/area/awaymission/station/hallway/floor1/aft
	name = "\improper First Floor Aft Hallway"
	icon_state = "1_aft"

/area/awaymission/station/hallway/floor1/fore
	name = "\improper First Floor Fore Hallway"
	icon_state = "1_fore"

/area/awaymission/station/hallway/floor2
	name = "\improper Second Floor Hallway"

/area/awaymission/station/hallway/floor2/aft
	name = "\improper Second Floor Aft Hallway"
	icon_state = "2_aft"

/area/awaymission/station/hallway/floor2/fore
	name = "\improper Second Floor Fore Hallway"
	icon_state = "2_fore"

/area/awaymission/station/hallway/floor3
	name = "\improper Third Floor Hallway"

/area/awaymission/station/hallway/floor3/aft
	name = "\improper Third Floor Aft Hallway"
	icon_state = "3_aft"

/area/awaymission/station/hallway/floor3/fore
	name = "\improper Third Floor Fore Hallway"
	icon_state = "3_fore"

/area/awaymission/station/hallway/floor4
	name = "\improper Fourth Floor Hallway"

/area/awaymission/station/hallway/floor4/aft
	name = "\improper Fourth Floor Aft Hallway"
	icon_state = "4_aft"

/area/awaymission/station/hallway/floor4/fore
	name = "\improper Fourth Floor Fore Hallway"
	icon_state = "4_fore"

//HELP MAINTS
/area/awaymission/station/maintenance
	name = "Generic Maintenance"
	ambience_index = AMBIENCE_MAINT
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED | PERSISTENT_ENGRAVINGS
	airlock_wires = /datum/wires/airlock/maint
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED
	forced_ambience = TRUE
	ambient_buzz = 'sound/ambience/maintenance/source_corridor2.ogg'
	ambient_buzz_vol = 20

/*
* Departmental Maintenance
*/

/area/awaymission/station/maintenance/department/chapel
	name = "Chapel Maintenance"
	icon_state = "maint_chapel"

/area/awaymission/station/maintenance/department/chapel/monastery
	name = "Monastery Maintenance"
	icon_state = "maint_monastery"

/area/awaymission/station/maintenance/department/crew_quarters/bar
	name = "Bar Maintenance"
	icon_state = "maint_bar"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/maintenance/department/crew_quarters/dorms
	name = "Dormitory Maintenance"
	icon_state = "maint_dorms"

/area/awaymission/station/maintenance/department/eva
	name = "EVA Maintenance"
	icon_state = "maint_eva"

/area/awaymission/station/maintenance/department/eva/abandoned
	name = "Abandoned EVA Storage"

/area/awaymission/station/maintenance/department/electrical
	name = "Electrical Maintenance"
	icon_state = "maint_electrical"

/area/awaymission/station/maintenance/department/engine/atmos
	name = "Atmospherics Maintenance"
	icon_state = "maint_atmos"

/area/awaymission/station/maintenance/department/security
	name = "Security Maintenance"
	icon_state = "maint_sec"

/area/awaymission/station/maintenance/department/security/upper
	name = "Upper Security Maintenance"

/area/awaymission/station/maintenance/department/security/brig
	name = "Brig Maintenance"
	icon_state = "maint_brig"

/area/awaymission/station/maintenance/department/medical
	name = "Medbay Maintenance"
	icon_state = "medbay_maint"

/area/awaymission/station/maintenance/department/medical/central
	name = "Central Medbay Maintenance"
	icon_state = "medbay_maint_central"

/area/awaymission/station/maintenance/department/medical/morgue
	name = "Morgue Maintenance"
	icon_state = "morgue_maint"

/area/awaymission/station/maintenance/department/science
	name = "Science Maintenance"
	icon_state = "maint_sci"

/area/awaymission/station/maintenance/department/science/central
	name = "Central Science Maintenance"
	icon_state = "maint_sci_central"

/area/awaymission/station/maintenance/department/cargo
	name = "Cargo Maintenance"
	icon_state = "maint_cargo"

/area/awaymission/station/maintenance/department/bridge
	name = "Bridge Maintenance"
	icon_state = "maint_bridge"

/area/awaymission/station/maintenance/department/engine
	name = "Engineering Maintenance"
	icon_state = "maint_engi"

/area/awaymission/station/maintenance/department/prison
	name = "Prison Maintenance"
	icon_state = "sec_prison"

/area/awaymission/station/maintenance/department/science/xenobiology
	name = "Xenobiology Maintenance"
	icon_state = "xenomaint"
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED | UNIQUE_AREA | XENOBIOLOGY_COMPATIBLE | CULT_PERMITTED

/*
* Generic Maintenance Tunnels
*/

/area/awaymission/station/maintenance/aft
	name = "Aft Maintenance"
	icon_state = "aftmaint"

/area/awaymission/station/maintenance/aft/upper
	name = "Upper Aft Maintenance"
	icon_state = "upperaftmaint"

/* Use greater variants of area definitions for when the station has two different sections of maintenance on the same z-level.
* Can stand alone without "lesser".
* This one means that this goes more fore/north than the "lesser" maintenance area.
*/
/area/awaymission/station/maintenance/aft/greater
	name = "Greater Aft Maintenance"
	icon_state = "greateraftmaint"

/* Use lesser variants of area definitions for when the station has two different sections of maintenance on the same z-level in conjunction with "greater".
* (just because it follows better).
* This one means that this goes more aft/south than the "greater" maintenance area.
*/

/area/awaymission/station/maintenance/aft/lesser
	name = "Lesser Aft Maintenance"
	icon_state = "lesseraftmaint"

/area/awaymission/station/maintenance/central
	name = "Central Maintenance"
	icon_state = "centralmaint"

/area/awaymission/station/maintenance/central/greater
	name = "Greater Central Maintenance"
	icon_state = "greatercentralmaint"

/area/awaymission/station/maintenance/central/lesser
	name = "Lesser Central Maintenance"
	icon_state = "lessercentralmaint"

/area/awaymission/station/maintenance/fore
	name = "Fore Maintenance"
	icon_state = "foremaint"

/area/awaymission/station/maintenance/fore/upper
	name = "Upper Fore Maintenance"
	icon_state = "upperforemaint"

/area/awaymission/station/maintenance/fore/greater
	name = "Greater Fore Maintenance"
	icon_state = "greaterforemaint"

/area/awaymission/station/maintenance/fore/lesser
	name = "Lesser Fore Maintenance"
	icon_state = "lesserforemaint"

/area/awaymission/station/maintenance/starboard
	name = "Starboard Maintenance"
	icon_state = "starboardmaint"

/area/awaymission/station/maintenance/starboard/upper
	name = "Upper Starboard Maintenance"
	icon_state = "upperstarboardmaint"

/area/awaymission/station/maintenance/starboard/central
	name = "Central Starboard Maintenance"
	icon_state = "centralstarboardmaint"

/area/awaymission/station/maintenance/starboard/greater
	name = "Greater Starboard Maintenance"
	icon_state = "greaterstarboardmaint"

/area/awaymission/station/maintenance/starboard/lesser
	name = "Lesser Starboard Maintenance"
	icon_state = "lesserstarboardmaint"

/area/awaymission/station/maintenance/starboard/aft
	name = "Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/awaymission/station/maintenance/starboard/fore
	name = "Fore Starboard Maintenance"
	icon_state = "fsmaint"

/area/awaymission/station/maintenance/port
	name = "Port Maintenance"
	icon_state = "portmaint"

/area/awaymission/station/maintenance/port/central
	name = "Central Port Maintenance"
	icon_state = "centralportmaint"

/area/awaymission/station/maintenance/port/greater
	name = "Greater Port Maintenance"
	icon_state = "greaterportmaint"

/area/awaymission/station/maintenance/port/lesser
	name = "Lesser Port Maintenance"
	icon_state = "lesserportmaint"

/area/awaymission/station/maintenance/port/aft
	name = "Aft Port Maintenance"
	icon_state = "apmaint"

/area/awaymission/station/maintenance/port/fore
	name = "Fore Port Maintenance"
	icon_state = "fpmaint"

/area/awaymission/station/maintenance/tram
	name = "Primary Tram Maintenance"

/area/awaymission/station/maintenance/tram/left
	name = "\improper Port Tram Underpass"
	icon_state = "mainttramL"

/area/awaymission/station/maintenance/tram/mid
	name = "\improper Central Tram Underpass"
	icon_state = "mainttramM"

/area/awaymission/station/maintenance/tram/right
	name = "\improper Starboard Tram Underpass"
	icon_state = "mainttramR"

/*
* Discrete Maintenance Areas
*/

/area/awaymission/station/maintenance/disposal
	name = "Waste Disposal"
	icon_state = "disposal"

/area/awaymission/station/maintenance/hallway/abandoned_command
	name = "\improper Abandoned Command Hallway"
	icon_state = "maint_bridge"

/area/awaymission/station/maintenance/hallway/abandoned_recreation
	name = "\improper Abandoned Recreation Hallway"
	icon_state = "maint_dorms"

/area/awaymission/station/maintenance/disposal/incinerator
	name = "\improper Incinerator"
	icon_state = "incinerator"

/area/awaymission/station/maintenance/space_hut
	name = "\improper Space Hut"
	icon_state = "spacehut"

/area/awaymission/station/maintenance/space_hut/cabin
	name = "Abandoned Cabin"

/area/awaymission/station/maintenance/space_hut/plasmaman
	name = "\improper Abandoned Plasmaman Friendly Startup"

/area/awaymission/station/maintenance/space_hut/observatory
	name = "\improper Space Observatory"

/*
* Radation Storm Shelters
*/

/area/awaymission/station/maintenance/radshelter
	name = "\improper Radstorm Shelter"
	icon_state = "radstorm_shelter"

/area/awaymission/station/maintenance/radshelter/medical
	name = "\improper Medical Radstorm Shelter"

/area/awaymission/station/maintenance/radshelter/sec
	name = "\improper Security Radstorm Shelter"

/area/awaymission/station/maintenance/radshelter/service
	name = "\improper Service Radstorm Shelter"

/area/awaymission/station/maintenance/radshelter/civil
	name = "\improper Civilian Radstorm Shelter"

/area/awaymission/station/maintenance/radshelter/sci
	name = "\improper Science Radstorm Shelter"

/area/awaymission/station/maintenance/radshelter/cargo
	name = "\improper Cargo Radstorm Shelter"

/*
* External Hull Access Areas
*/

/area/awaymission/station/maintenance/external
	name = "\improper External Hull Access"
	icon_state = "amaint"

/area/awaymission/station/maintenance/external/aft
	name = "\improper Aft External Hull Access"

/area/awaymission/station/maintenance/external/port
	name = "\improper Port External Hull Access"

/area/awaymission/station/maintenance/external/port/bow
	name = "\improper Port Bow External Hull Access"

/*
* Station Specific Areas
* If another station gets added, and you make specific areas for it
* Please make its own section in this file
* The areas below belong to North Star's Maintenance
*/

//1
/area/awaymission/station/maintenance/floor1
	name = "\improper 1st Floor Maint"

/area/awaymission/station/maintenance/floor1/port
	name = "\improper 1st Floor Central Port Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor1/port/fore
	name = "\improper 1st Floor Fore Port Maint"
	icon_state = "maintfore"
/area/awaymission/station/maintenance/floor1/port/aft
	name = "\improper 1st Floor Aft Port Maint"
	icon_state = "maintaft"

/area/awaymission/station/maintenance/floor1/starboard
	name = "\improper 1st Floor Central Starboard Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor1/starboard/fore
	name = "\improper 1st Floor Fore Starboard Maint"
	icon_state = "maintfore"

/area/awaymission/station/maintenance/floor1/starboard/aft
	name = "\improper 1st Floor Aft Starboard Maint"
	icon_state = "maintaft"
//2
/area/awaymission/station/maintenance/floor2
	name = "\improper 2nd Floor Maint"
/area/awaymission/station/maintenance/floor2/port
	name = "\improper 2nd Floor Central Port Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor2/port/fore
	name = "\improper 2nd Floor Fore Port Maint"
	icon_state = "maintfore"

/area/awaymission/station/maintenance/floor2/port/aft
	name = "\improper 2nd Floor Aft Port Maint"
	icon_state = "maintaft"

/area/awaymission/station/maintenance/floor2/starboard
	name = "\improper 2nd Floor Central Starboard Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor2/starboard/fore
	name = "\improper 2nd Floor Fore Starboard Maint"
	icon_state = "maintfore"

/area/awaymission/station/maintenance/floor2/starboard/aft
	name = "\improper 2nd Floor Aft Starboard Maint"
	icon_state = "maintaft"
//3
/area/awaymission/station/maintenance/floor3
	name = "\improper 3rd Floor Maint"

/area/awaymission/station/maintenance/floor3/port
	name = "\improper 3rd Floor Central Port Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor3/port/fore
	name = "\improper 3rd Floor Fore Port Maint"
	icon_state = "maintfore"

/area/awaymission/station/maintenance/floor3/port/aft
	name = "\improper 3rd Floor Aft Port Maint"
	icon_state = "maintaft"

/area/awaymission/station/maintenance/floor3/starboard
	name = "\improper 3rd Floor Central Starboard Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor3/starboard/fore
	name = "\improper 3rd Floor Fore Starboard Maint"
	icon_state = "maintfore"

/area/awaymission/station/maintenance/floor3/starboard/aft
	name = "\improper 3rd Floor Aft Starboard Maint"
	icon_state = "maintaft"
//4
/area/awaymission/station/maintenance/floor4
	name = "\improper 4th Floor Maint"

/area/awaymission/station/maintenance/floor4/port
	name = "\improper 4th Floor Central Port Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor4/port/fore
	name = "\improper 4th Floor Fore Port Maint"
	icon_state = "maintfore"

/area/awaymission/station/maintenance/floor4/port/aft
	name = "\improper 4th Floor Aft Port Maint"
	icon_state = "maintaft"

/area/awaymission/station/maintenance/floor4/starboard
	name = "\improper 4th Floor Central Starboard Maint"
	icon_state = "maintcentral"

/area/awaymission/station/maintenance/floor4/starboard/fore
	name = "\improper 4th Floor Fore Starboard Maint"
	icon_state = "maintfore"

/area/awaymission/station/maintenance/floor4/starboard/aft
	name = "\improper 4th Floor Aft Starboard Maint"
	icon_state = "maintaft"

//MEDBAY
/area/awaymission/station/medical
	name = "Medical"
	icon_state = "medbay"
	ambience_index = AMBIENCE_MEDICAL
	airlock_wires = /datum/wires/airlock/medbay
	sound_environment = SOUND_AREA_STANDARD_STATION
	min_ambience_cooldown = 90 SECONDS
	max_ambience_cooldown = 180 SECONDS

/area/awaymission/station/medical/abandoned
	name = "\improper Abandoned Medbay"
	icon_state = "abandoned_medbay"
	ambientsounds = list(
		'sound/ambience/misc/signal.ogg',
		)
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/medical/medbay/central
	name = "Medbay Central"
	icon_state = "med_central"

/area/awaymission/station/medical/lower
	name = "\improper Lower Medbay"
	icon_state = "lower_med"

/area/awaymission/station/medical/medbay/lobby
	name = "\improper Medbay Lobby"
	icon_state = "med_lobby"

/area/awaymission/station/medical/medbay/aft
	name = "Medbay Aft"
	icon_state = "med_aft"

/area/awaymission/station/medical/storage
	name = "Medbay Storage"
	icon_state = "med_storage"

/area/awaymission/station/medical/paramedic
	name = "Paramedic Dispatch"
	icon_state = "paramedic"

/area/awaymission/station/medical/office
	name = "\improper Medical Office"
	icon_state = "med_office"

/area/awaymission/station/medical/break_room
	name = "\improper Medical Break Room"
	icon_state = "med_break"

/area/awaymission/station/medical/coldroom
	name = "\improper Medical Cold Room"
	icon_state = "kitchen_cold"

/area/awaymission/station/medical/patients_rooms
	name = "\improper Patients' Rooms"
	icon_state = "patients"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/medical/patients_rooms/room_a
	name = "Patient Room A"
	icon_state = "patients"

/area/awaymission/station/medical/patients_rooms/room_b
	name = "Patient Room B"
	icon_state = "patients"

/area/awaymission/station/medical/virology
	name = "Virology"
	icon_state = "virology"
	ambience_index = AMBIENCE_VIROLOGY

/area/awaymission/station/medical/virology/isolation
	name = "Virology Isolation"
	icon_state = "virology_isolation"

/area/awaymission/station/medical/morgue
	name = "\improper Morgue"
	icon_state = "morgue"
	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/medical/chemistry
	name = "Chemistry"
	icon_state = "chem"

/area/awaymission/station/medical/chemistry/minisat
	name = "Chemistry Mini-Satellite"

/area/awaymission/station/medical/pharmacy
	name = "\improper Pharmacy"
	icon_state = "pharmacy"

/area/awaymission/station/medical/chem_storage
	name = "\improper Chemical Storage"
	icon_state = "chem_storage"

/area/awaymission/station/medical/surgery
	name = "\improper Operating Room"
	icon_state = "surgery"

/area/awaymission/station/medical/surgery/fore
	name = "\improper Fore Operating Room"
	icon_state = "foresurgery"

/area/awaymission/station/medical/surgery/aft
	name = "\improper Aft Operating Room"
	icon_state = "aftsurgery"

/area/awaymission/station/medical/surgery/theatre
	name = "\improper Grand Surgery Theatre"
	icon_state = "surgerytheatre"

/area/awaymission/station/medical/cryo
	name = "Cryogenics"
	icon_state = "cryo"

/area/awaymission/station/medical/exam_room
	name = "\improper Exam Room"
	icon_state = "exam_room"

/area/awaymission/station/medical/treatment_center
	name = "\improper Medbay Treatment Center"
	icon_state = "exam_room"

/area/awaymission/station/medical/psychology
	name = "\improper Psychology Office"
	icon_state = "psychology"
	mood_bonus = 3
	mood_message = "I feel at ease here."
	ambientsounds = list(
		'sound/ambience/aurora_caelus/aurora_caelus_short.ogg',
		)

//SCIENCE
/area/awaymission/station/science
	name = "\improper Science Division"
	icon_state = "science"
	airlock_wires = /datum/wires/airlock/science
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/science/lobby
	name = "\improper Science Lobby"
	icon_state = "science_lobby"

/area/awaymission/station/science/lower
	name = "\improper Lower Science Division"
	icon_state = "lower_science"

/area/awaymission/station/science/breakroom
	name = "\improper Science Break Room"
	icon_state = "science_breakroom"

/area/awaymission/station/science/lab
	name = "Research and Development"
	icon_state = "research"

/area/awaymission/station/science/xenobiology
	name = "\improper Xenobiology Lab"
	icon_state = "xenobio"

/area/awaymission/station/science/xenobiology/hallway
	name = "\improper Xenobiology Hallway"
	icon_state = "xenobio_hall"

/area/awaymission/station/science/cytology
	name = "\improper Cytology Lab"
	icon_state = "cytology"

/area/awaymission/station/science/cubicle
	name = "\improper Science Cubicles"
	icon_state = "science"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/awaymission/station/science/genetics
	name = "\improper Genetics Lab"
	icon_state = "geneticssci"

/area/awaymission/station/science/server
	name = "\improper Research Division Server Room"
	icon_state = "server"

/area/awaymission/station/science/circuits
	name = "\improper Circuit Lab"
	icon_state = "cir_lab"

/area/awaymission/station/science/explab
	name = "\improper Experimentation Lab"
	icon_state = "exp_lab"

/area/awaymission/station/science/auxlab
	name = "\improper Auxiliary Lab"
	icon_state = "aux_lab"

/area/awaymission/station/science/auxlab/firing_range
	name = "\improper Research Firing Range"

/area/awaymission/station/science/robotics
	name = "Robotics"
	icon_state = "robotics"

/area/awaymission/station/science/robotics/mechbay
	name = "\improper Mech Bay"
	icon_state = "mechbay"

/area/awaymission/station/science/robotics/lab
	name = "\improper Robotics Lab"
	icon_state = "ass_line"

/area/awaymission/station/science/robotics/storage
	name = "\improper Robotics Storage"
	icon_state = "ass_line"

/area/awaymission/station/science/robotics/augments
	name = "\improper Augmentation Theater"
	icon_state = "robotics"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/awaymission/station/science/research
	name = "\improper Research Division"
	icon_state = "science"

/area/awaymission/station/science/research/abandoned
	name = "\improper Abandoned Research Lab"
	icon_state = "abandoned_sci"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/*
* Ordnance Areas
*/

// Use this for the main lab. If test equipment, storage, etc is also present use this one too.
/area/awaymission/station/science/ordnance
	name = "\improper Ordnance Lab"
	icon_state = "ord_main"

/area/awaymission/station/science/ordnance/office
	name = "\improper Ordnance Office"
	icon_state = "ord_office"

/area/awaymission/station/science/ordnance/storage
	name = "\improper Ordnance Storage"
	icon_state = "ord_storage"

/area/awaymission/station/science/ordnance/burnchamber
	name = "\improper Ordnance Burn Chamber"
	icon_state = "ord_burn"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

/area/awaymission/station/science/ordnance/freezerchamber
	name = "\improper Ordnance Freezer Chamber"
	icon_state = "ord_freeze"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

// Room for equipments and such
/area/awaymission/station/science/ordnance/testlab
	name = "\improper Ordnance Testing Lab"
	icon_state = "ord_test"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

/area/awaymission/station/science/ordnance/bomb
	name = "\improper Ordnance Bomb Site"
	icon_state = "ord_boom"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED

//SEC
// When adding a new area to the security areas, make sure to add it to /datum/bounty/item/security/paperwork as well!

/area/awaymission/station/security
	name = "Security"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/security/office
	name = "\improper Security Office"
	icon_state = "security"

/area/awaymission/station/security/breakroom
	name = "\improper Security Break Room"
	icon_state = "brig"

/area/awaymission/station/security/tram
	name = "\improper Security Transfer Tram"
	icon_state = "security"

/area/awaymission/station/security/lockers
	name = "\improper Security Locker Room"
	icon_state = "securitylockerroom"

/area/awaymission/station/security/brig
	name = "\improper Brig"
	icon_state = "brig"

/area/awaymission/station/security/holding_cell
	name = "\improper Holding Cell"
	icon_state = "holding_cell"

/area/awaymission/station/security/medical
	name = "\improper Security Medical"
	icon_state = "security_medical"

/area/awaymission/station/security/brig/upper
	name = "\improper Brig Overlook"
	icon_state = "upperbrig"

/area/awaymission/station/security/brig/lower
	name = "\improper Lower Brig"
	icon_state = "lower_brig"

/area/awaymission/station/security/brig/entrance
	name = "\improper Brig Entrance"
	icon_state = "brigentry"

/area/awaymission/station/security/courtroom
	name = "\improper Courtroom"
	icon_state = "courtroom"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/security/courtroom/holding
	name = "\improper Courtroom Prisoner Holding Room"

/area/awaymission/station/security/processing
	name = "\improper Labor Shuttle Dock"
	icon_state = "sec_labor_processing"

/area/awaymission/station/security/processing/cremation
	name = "\improper Security Crematorium"
	icon_state = "sec_cremation"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/security/interrogation
	name = "\improper Interrogation Room"
	icon_state = "interrogation"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/security/warden
	name = "Brig Control"
	icon_state = "warden"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/security/evidence
	name = "Evidence Storage"
	icon_state = "evidence"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/security/detectives_office
	name = "\improper Detective's Office"
	icon_state = "detective"
	ambientsounds = list(
		'sound/ambience/security/ambidet1.ogg',
		'sound/ambience/security/ambidet2.ogg',
		)

/area/awaymission/station/security/detectives_office/private_investigators_office
	name = "\improper Private Investigator's Office"
	icon_state = "investigate_office"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/security/range
	name = "\improper Firing Range"
	icon_state = "firingrange"

/area/awaymission/station/security/eva
	name = "\improper Security EVA"
	icon_state = "sec_eva"

/area/awaymission/station/security/execution
	icon_state = "execution_room"

/area/awaymission/station/security/execution/transfer
	name = "\improper Transfer Centre"
	icon_state = "sec_processing"

/area/awaymission/station/security/execution/education
	name = "\improper Prisoner Education Chamber"

/area/awaymission/station/security/mechbay
	name = "Security Mechbay"
	icon_state = "sec_mechbay"

/*
* Security Checkpoints
*/

/area/awaymission/station/security/checkpoint
	name = "\improper Security Checkpoint"
	icon_state = "checkpoint"

/area/awaymission/station/security/checkpoint/escape
	name = "\improper Departures Security Checkpoint"
	icon_state = "checkpoint_esc"

/area/awaymission/station/security/checkpoint/arrivals
	name = "\improper Arrivals Security Checkpoint"
	icon_state = "checkpoint_arr"

/area/awaymission/station/security/checkpoint/supply
	name = "Security Post - Cargo Bay"
	icon_state = "checkpoint_supp"

/area/awaymission/station/security/checkpoint/engineering
	name = "Security Post - Engineering"
	icon_state = "checkpoint_engi"

/area/awaymission/station/security/checkpoint/medical
	name = "Security Post - Medbay"
	icon_state = "checkpoint_med"

/area/awaymission/station/security/checkpoint/medical/medsci
	name = "Security Post - Medsci"

/area/awaymission/station/security/checkpoint/science
	name = "Security Post - Science"
	icon_state = "checkpoint_sci"

/area/awaymission/station/security/checkpoint/science/research
	name = "Security Post - Research Division"
	icon_state = "checkpoint_res"

/area/awaymission/station/security/checkpoint/customs
	name = "Customs"
	icon_state = "customs_point"

/area/awaymission/station/security/checkpoint/customs/auxiliary
	name = "Auxiliary Customs"
	icon_state = "customs_point_aux"

/area/awaymission/station/security/checkpoint/customs/fore
	name = "Fore Customs"
	icon_state = "customs_point_fore"

/area/awaymission/station/security/checkpoint/customs/aft
	name = "Aft Customs"
	icon_state = "customs_point_aft"

/area/awaymission/station/security/checkpoint/first
	name = "Security Post - First Floor"
	icon_state = "checkpoint_1"

/area/awaymission/station/security/checkpoint/second
	name = "Security Post - Second Floor"
	icon_state = "checkpoint_2"

/area/awaymission/station/security/checkpoint/third
	name = "Security Post - Third Floor"
	icon_state = "checkpoint_3"


/area/awaymission/station/security/prison
	name = "\improper Prison Wing"
	icon_state = "sec_prison"
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED | PERSISTENT_ENGRAVINGS

//Rad proof
/area/awaymission/station/security/prison/toilet
	name = "\improper Prison Toilet"
	icon_state = "sec_prison_safe"

// Rad proof
/area/awaymission/station/security/prison/safe
	name = "\improper Prison Wing Cells"
	icon_state = "sec_prison_safe"

/area/awaymission/station/security/prison/upper
	name = "\improper Upper Prison Wing"
	icon_state = "prison_upper"

/area/awaymission/station/security/prison/visit
	name = "\improper Prison Visitation Area"
	icon_state = "prison_visit"

/area/awaymission/station/security/prison/rec
	name = "\improper Prison Rec Room"
	icon_state = "prison_rec"

/area/awaymission/station/security/prison/mess
	name = "\improper Prison Mess Hall"
	icon_state = "prison_mess"

/area/awaymission/station/security/prison/work
	name = "\improper Prison Work Room"
	icon_state = "prison_work"

/area/awaymission/station/security/prison/shower
	name = "\improper Prison Shower"
	icon_state = "prison_shower"

/area/awaymission/station/security/prison/workout
	name = "\improper Prison Gym"
	icon_state = "prison_workout"

/area/awaymission/station/security/prison/garden
	name = "\improper Prison Garden"
	icon_state = "prison_garden"

//SERVICE
/area/awaymission/station/service
	airlock_wires = /datum/wires/airlock/service

/*
* Bar/Kitchen Areas
*/

/area/awaymission/station/service/cafeteria
	name = "\improper Cafeteria"
	icon_state = "cafeteria"

/area/awaymission/station/service/minibar
	name = "\improper Mini Bar"
	icon_state = "minibar"

/area/awaymission/station/service/kitchen
	name = "\improper Kitchen"
	icon_state = "kitchen"

/area/awaymission/station/service/kitchen/coldroom
	name = "\improper Kitchen Cold Room"
	icon_state = "kitchen_cold"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/service/kitchen/diner
	name = "\improper Diner"
	icon_state = "diner"

/area/awaymission/station/service/kitchen/kitchen_backroom
	name = "\improper Kitchen Backroom"
	icon_state = "kitchen_backroom"

/area/awaymission/station/service/bar
	name = "\improper Bar"
	icon_state = "bar"
	mood_bonus = 5
	mood_message = "I love being in the bar!"
	mood_trait = TRAIT_EXTROVERT
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/service/bar/Initialize(mapload)
	. = ..()
	GLOB.bar_areas += src

/area/awaymission/station/service/bar/atrium
	name = "\improper Atrium"
	icon_state = "bar"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/service/bar/backroom
	name = "\improper Bar Backroom"
	icon_state = "bar_backroom"

/*
* Entertainment/Library Areas
*/

/area/awaymission/station/service/theater
	name = "\improper Theater"
	icon_state = "theatre"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/awaymission/station/service/theater_dressing
	name = "\improper Theater Dressing Room"
	icon_state = "theatre_dressing"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/service/greenroom
	name = "\improper Greenroom"
	icon_state = "theatre_green"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/service/library
	name = "\improper Library"
	icon_state = "library"
	mood_bonus = 5
	mood_message = "I love being in the library!"
	mood_trait = TRAIT_INTROVERT
	area_flags = CULT_PERMITTED | BLOBS_ALLOWED | UNIQUE_AREA
	sound_environment = SOUND_AREA_LARGE_SOFTFLOOR

/area/awaymission/station/service/library/garden
	name = "\improper Library Garden"
	icon_state = "library_garden"

/area/awaymission/station/service/library/lounge
	name = "\improper Library Lounge"
	icon_state = "library_lounge"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/service/library/artgallery
	name = "\improper  Art Gallery"
	icon_state = "library_gallery"

/area/awaymission/station/service/library/private
	name = "\improper Library Private Study"
	icon_state = "library_gallery_private"

/area/awaymission/station/service/library/upper
	name = "\improper Library Upper Floor"
	icon_state = "library"

/area/awaymission/station/service/library/printer
	name = "\improper Library Printer Room"
	icon_state = "library"

/*
* Chapel/Pubby Monestary Areas
*/

/area/awaymission/station/service/chapel
	name = "\improper Chapel"
	icon_state = "chapel"
	mood_bonus = 5
	mood_message = "Being in the chapel brings me peace."
	mood_trait = TRAIT_SPIRITUAL
	ambience_index = AMBIENCE_HOLY
	flags_1 = NONE
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/service/chapel/monastery
	name = "\improper Monastery"

/area/awaymission/station/service/chapel/office
	name = "\improper Chapel Office"
	icon_state = "chapeloffice"

/area/awaymission/station/service/chapel/asteroid
	name = "\improper Chapel Asteroid"
	icon_state = "explored"
	sound_environment = SOUND_AREA_ASTEROID

/area/awaymission/station/service/chapel/asteroid/monastery
	name = "\improper Monastery Asteroid"

/area/awaymission/station/service/chapel/dock
	name = "\improper Chapel Dock"
	icon_state = "construction"

/area/awaymission/station/service/chapel/storage
	name = "\improper Chapel Storage"
	icon_state = "chapelstorage"

/area/awaymission/station/service/chapel/funeral
	name = "\improper Chapel Funeral Room"
	icon_state = "chapelfuneral"

/area/awaymission/station/service/hydroponics/garden/monastery
	name = "\improper Monastery Garden"
	icon_state = "hydro"

/*
* Hydroponics/Garden Areas
*/

/area/awaymission/station/service/hydroponics
	name = "Hydroponics"
	icon_state = "hydro"
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/service/hydroponics/upper
	name = "Upper Hydroponics"
	icon_state = "hydro"

/area/awaymission/station/service/hydroponics/garden
	name = "Garden"
	icon_state = "garden"

/*
* Misc/Unsorted Rooms
*/

/area/awaymission/station/service/lawoffice
	name = "\improper Law Office"
	icon_state = "law"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/awaymission/station/service/janitor
	name = "\improper Custodial Closet"
	icon_state = "janitor"
	area_flags = CULT_PERMITTED | BLOBS_ALLOWED | UNIQUE_AREA
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/service/barber
	name = "\improper Barber"
	icon_state = "barber"

/area/awaymission/station/service/boutique
	name = "\improper Boutique"
	icon_state = "boutique"

/*
* Abandoned Rooms
*/

/area/awaymission/station/service/hydroponics/garden/abandoned
	name = "\improper Abandoned Garden"
	icon_state = "abandoned_garden"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/service/kitchen/abandoned
	name = "\improper Abandoned Kitchen"
	icon_state = "abandoned_kitchen"

/area/awaymission/station/service/electronic_marketing_den
	name = "\improper Electronic Marketing Den"
	icon_state = "abandoned_marketing_den"

/area/awaymission/station/service/abandoned_gambling_den
	name = "\improper Abandoned Gambling Den"
	icon_state = "abandoned_gambling_den"

/area/awaymission/station/service/abandoned_gambling_den/gaming
	name = "\improper Abandoned Gaming Den"
	icon_state = "abandoned_gaming_den"

/area/awaymission/station/service/theater/abandoned
	name = "\improper Abandoned Theater"
	icon_state = "abandoned_theatre"

/area/awaymission/station/service/library/abandoned
	name = "\improper Abandoned Library"
	icon_state = "abandoned_library"

//SOLARS
/*
* External Solar Areas
*/

/area/awaymission/station/solars
	icon_state = "panels"
	requires_power = FALSE
	area_flags = NONE
	flags_1 = NONE
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_SPACE

/area/awaymission/station/solars/fore
	name = "\improper Fore Solar Array"
	icon_state = "panelsF"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/solars/aft
	name = "\improper Aft Solar Array"
	icon_state = "panelsAF"

/area/awaymission/station/solars/aux/port
	name = "\improper Port Bow Auxiliary Solar Array"
	icon_state = "panelsA"

/area/awaymission/station/solars/aux/starboard
	name = "\improper Starboard Bow Auxiliary Solar Array"
	icon_state = "panelsA"

/area/awaymission/station/solars/starboard
	name = "\improper Starboard Solar Array"
	icon_state = "panelsS"

/area/awaymission/station/solars/starboard/aft
	name = "\improper Starboard Quarter Solar Array"
	icon_state = "panelsAS"

/area/awaymission/station/solars/starboard/fore
	name = "\improper Starboard Bow Solar Array"
	icon_state = "panelsFS"

/area/awaymission/station/solars/port
	name = "\improper Port Solar Array"
	icon_state = "panelsP"

/area/awaymission/station/solars/port/aft
	name = "\improper Port Quarter Solar Array"
	icon_state = "panelsAP"

/area/awaymission/station/solars/port/fore
	name = "\improper Port Bow Solar Array"
	icon_state = "panelsFP"

/area/awaymission/station/solars/aisat
	name = "\improper AI Satellite Solars"
	icon_state = "panelsAI"


/*
* Internal Solar Areas
* The rooms where the SMES and computer are
* Not in the maintenance file just so we can keep these organized with other the external solar areas
*/

/area/awaymission/station/maintenance/solars
	name = "Solar Maintenance"
	icon_state = "yellow"

/area/awaymission/station/maintenance/solars/port
	name = "Port Solar Maintenance"
	icon_state = "SolarcontrolP"

/area/awaymission/station/maintenance/solars/port/aft
	name = "Port Quarter Solar Maintenance"
	icon_state = "SolarcontrolAP"

/area/awaymission/station/maintenance/solars/port/fore
	name = "Port Bow Solar Maintenance"
	icon_state = "SolarcontrolFP"

/area/awaymission/station/maintenance/solars/starboard
	name = "Starboard Solar Maintenance"
	icon_state = "SolarcontrolS"

/area/awaymission/station/maintenance/solars/starboard/aft
	name = "Starboard Quarter Solar Maintenance"
	icon_state = "SolarcontrolAS"

/area/awaymission/station/maintenance/solars/starboard/fore
	name = "Starboard Bow Solar Maintenance"
	icon_state = "SolarcontrolFS"

//TCOMMS
/*
* Telecommunications Satellite Areas
*/

/area/awaymission/station/tcommsat
	icon_state = "tcomsatcham"
	ambientsounds = list(
		'sound/ambience/engineering/ambisin2.ogg',
		'sound/ambience/misc/signal.ogg',
		'sound/ambience/misc/signal.ogg',
		'sound/ambience/general/ambigen9.ogg',
		'sound/ambience/engineering/ambitech.ogg',
		'sound/ambience/engineering/ambitech2.ogg',
		'sound/ambience/engineering/ambitech3.ogg',
		'sound/ambience/misc/ambimystery.ogg',
		)
	airlock_wires = /datum/wires/airlock/engineering

/area/awaymission/station/tcommsat/computer
	name = "\improper Telecomms Control Room"
	icon_state = "tcomsatcomp"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/awaymission/station/tcommsat/server
	name = "\improper Telecomms Server Room"
	icon_state = "tcomsatcham"

/area/awaymission/station/tcommsat/server/upper
	name = "\improper Upper Telecomms Server Room"

/*
* On-Station Telecommunications Areas
*/

/area/awaymission/station/comms
	name = "\improper Communications Relay"
	icon_state = "tcomsatcham"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/server
	name = "\improper Messaging Server Room"
	icon_state = "server"
	sound_environment = SOUND_AREA_STANDARD_STATION

//AI STUFF
// Specific AI monitored areas

// Stub defined ai_monitored.dm
/area/awaymission/station/ai_monitored

/area/awaymission/station/ai_monitored/turret_protected

// AI
/area/awaymission/station/ai_monitored
	icon_state = "ai"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/awaymission/station/ai_monitored/aisat/exterior
	name = "\improper AI Satellite Exterior"
	icon_state = "ai"
	airlock_wires = /datum/wires/airlock/ai

/area/awaymission/station/ai_monitored/command/storage/satellite
	name = "\improper AI Satellite Maint"
	icon_state = "ai_storage"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/ai

// Turret protected
/area/awaymission/station/ai_monitored/turret_protected
	ambientsounds = list('sound/ambience/engineering/ambitech.ogg', 'sound/ambience/engineering/ambitech2.ogg', 'sound/ambience/engineering/ambiatmos.ogg', 'sound/ambience/engineering/ambiatmos2.ogg')
	///Some sounds (like the space jam) are terrible when on loop. We use this variable to add it to other AI areas, but override it to keep it from the AI's core.
	var/ai_will_not_hear_this = list('sound/ambience/misc/ambimalf.ogg')
	airlock_wires = /datum/wires/airlock/ai

/area/awaymission/station/ai_monitored/turret_protected/Initialize(mapload)
	. = ..()
	if(ai_will_not_hear_this)
		ambientsounds += ai_will_not_hear_this

/area/awaymission/station/ai_monitored/turret_protected/ai_upload
	name = "\improper AI Upload Chamber"
	icon_state = "ai_upload"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/ai_monitored/turret_protected/ai_upload_foyer
	name = "\improper AI Upload Access"
	icon_state = "ai_upload_foyer"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/awaymission/station/ai_monitored/turret_protected/ai
	name = "\improper AI Chamber"
	icon_state = "ai_chamber"
	ai_will_not_hear_this = null

/area/awaymission/station/ai_monitored/turret_protected/aisat
	name = "\improper AI Satellite"
	icon_state = "ai"
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/awaymission/station/ai_monitored/turret_protected/aisat/atmos
	name = "\improper AI Satellite Atmos"
	icon_state = "ai"

/area/awaymission/station/ai_monitored/turret_protected/aisat/foyer
	name = "\improper AI Satellite Foyer"
	icon_state = "ai_foyer"

/area/awaymission/station/ai_monitored/turret_protected/aisat/service
	name = "\improper AI Satellite Service"
	icon_state = "ai"

/area/awaymission/station/ai_monitored/turret_protected/aisat/hallway
	name = "\improper AI Satellite Hallway"
	icon_state = "ai"

/area/awaymission/station/ai_monitored/turret_protected/aisat/teleporter
	name ="\improper AI Satellite Teleporter"
	icon_state = "ai"

/area/awaymission/station/ai_monitored/turret_protected/aisat/equipment
	name ="\improper AI Satellite Equipment"
	icon_state = "ai"

/area/awaymission/station/ai_monitored/turret_protected/aisat/maint
	name = "\improper AI Satellite Maintenance"
	icon_state = "ai_maint"

/area/awaymission/station/ai_monitored/turret_protected/aisat/uppernorth
	name = "\improper AI Satellite Upper Fore"
	icon_state = "ai"

/area/awaymission/station/ai_monitored/turret_protected/aisat/uppersouth
	name = "\improper AI Satellite Upper Aft"
	icon_state = "ai"

/area/awaymission/station/ai_monitored/turret_protected/aisat_interior
	name = "\improper AI Satellite Antechamber"
	icon_state = "ai_interior"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/awaymission/station/ai_monitored/turret_protected/ai_sat_ext_as
	name = "\improper AI Sat Ext"
	icon_state = "ai_sat_east"

/area/awaymission/station/ai_monitored/turret_protected/ai_sat_ext_ap
	name = "\improper AI Sat Ext"
	icon_state = "ai_sat_west"

// Station specific ai monitored rooms, move here for consistency

//Command - AI Monitored
/area/awaymission/station/ai_monitored/command/storage/eva
	name = "EVA Storage"
	icon_state = "eva"
	ambience_index = AMBIENCE_DANGER

/area/awaymission/station/ai_monitored/command/storage/eva/upper
	name = "Upper EVA Storage"

/area/awaymission/station/ai_monitored/command/nuke_storage
	name = "\improper Vault"
	icon_state = "nuke_storage"
	airlock_wires = /datum/wires/airlock/command

//Security - AI Monitored
/area/awaymission/station/ai_monitored/security/armory
	name = "\improper Armory"
	icon_state = "armory"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security

/area/awaymission/station/ai_monitored/security/armory/upper
	name = "Upper Armory"

