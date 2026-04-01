/area/station/solars/asteroid
	name = "\improper Ministation Solar Array"
	icon_state = "panelsAF"

/area/station/engineering/atmos/asteroid
	name = "\improper Ministation Atmospherics Room"
	icon_state = "atmos"

/area/station/engineering/asteroid_lobby
	name = "\improper Ministation Lobby"
	icon_state = "engine_hallway"


//Additional Station Areas

/area/station/common/cryopods/aux
	name = "\improper Aux. Cryopods Room"

/area/station/commons/public_mining
	name = "\improper Public Mining"
	icon_state = "mining"

/area/station/commons/public_xenoarch
	name = "\improper Public Xenoarchaeology"
	icon_state = "exp_lab"

/area/station/maintenance/department/engine/shuttle_construction_bay
	name = "\improper Shuttle Construction Bay"
	icon_state = "maint_eva"
	allow_shuttle_docking = TRUE

/area/station/maintenance/department/public_mining
	name = "\improper Public Mining Maintenance"
	icon_state = "centralmaint"

/area/station/maintenance/department/medical/chemistry
	name = "\improper Chemistry Maintenance"
	icon_state = "centralmaint"

/area/station/engineering/supermatter/emitter
	name = "\improper Supermatter Emitter Room"
	icon_state = "engine_control"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/station/service/service_room
	name = "\improper Service Lathe"
	icon_state = "hall_service"

/area/station/medical/morgue/office
	name = "\improper Coroner's Office"
	icon_state = "ass_line" //You try finding a matching area icon, fucko.

/area/station/commons/public_dock
	name = "\improper Public Shuttle Dock"
	icon_state = "podbay"

/area/station/terminal
	name = "\improper Arrivals Terminal"
	icon_state = "station"
	area_flags = EVENT_PROTECTED

/area/station/terminal/cryo
	name = "\improper Arrivals Terminal Cryo"
	icon_state = "cryo"

/area/station/terminal/interlink
	name = "\improper Arrivals Terminal Interlink Dock"
	icon_state = "entry"

/area/station/terminal/lobby
	name = "\improper Arrivals Terminal Lobby"
	icon_state = "lounge"

/area/station/terminal/maintenance
	name = "\improper Arrivals Terminal Central Maintenance"
	icon_state = "maintcentral"

/area/station/terminal/maintenance/fore
	name = "\improper Arrivals Terminal Disposals"
	icon_state = "maintfore"

/area/station/terminal/maintenance/aft
	name = "\improper Arrivals Terminal Aft Maintenance"
	icon_state = "maintaft"

/area/station/terminal/tramline
	name = "\improper Tramline"
	icon_state = "shuttle"
	requires_power = FALSE //Imagine if your funny gimmick had no power and people had to walk lmao

/area/station/engineering/storage/eva
	name = "\improper Engineering EVA Storage"
	icon_state = "eva"

/area/moonstation
	name = "DO NOT USE"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = NONE
	area_flags_mapping = UNIQUE_AREA | FLORA_ALLOWED
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'
	allow_shuttle_docking = TRUE

/area/moonstation/surface
	name = "\improper Lunar Surface"
	icon_state = "explored"
	outdoors = TRUE
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	area_flags_mapping = UNIQUE_AREA | FLORA_ALLOWED
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/moonstation/surface/LateInitialize()

	//Lighting
	var/sunlight_freq = 6
	for(var/turf/lighting_turf in contents)
		if(lighting_turf.light)
			continue
		if(lighting_turf.x % sunlight_freq)
			continue
		var/bonus = !(lighting_turf.x % (sunlight_freq*2)) && sunlight_freq > 1 ? sunlight_freq*0.5 : 0
		if((lighting_turf.y+bonus) % sunlight_freq)
			continue
		lighting_turf.set_light(
			1 + sunlight_freq,
			1,
			"#724C2B"
		)

/area/moonstation/surface/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY
	area_flags_mapping = UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/moonstation

/area/moonstation/underground
	name = "\improper Lunar Caves"
	outdoors = TRUE
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	area_flags = NONE
	area_flags_mapping = UNIQUE_AREA | FLORA_ALLOWED
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/moonstation/underground/unexplored
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY
	area_flags_mapping = UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/moonstation/cave

/area/station/cargo/miningelevators
	name = "\improper Mining Elevators"
	icon_state = "unknown"
	area_flags = EVENT_PROTECTED

/area/station/cargo/miningfoundry/event_protected
	area_flags = EVENT_PROTECTED

/area/station/maintenance/department/medical/psychology
	name = "\improper Psychology Maintenance"
	icon_state = "unknown"

/area/station/maintenance/department/engine/lower
	name = "\improper Lower Engineering Maintenance"


//Loopstation Areas
/area/loopstation
	name = "Loop Station"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "station"
	default_gravity = ZERO_GRAVITY
	ambience_index = AMBIENCE_AWAY
	sound_environment = SOUND_ENVIRONMENT_ROOM
	area_flags = UNIQUE_AREA | EVENT_PROTECTED


/area/loopstation/gateway
	name = "Loop Station Gateway"
	icon_state = "gateway"

/area/loopstation/hallway
	name = "Loop Station Central Hallway"
	icon_state = "hall"

/area/loopstation/engineering
	name = "Loop Station Engineering"
	icon_state = "engie"
	airlock_wires = /datum/wires/airlock/engineering
	ambience_index = AMBIENCE_ENGI

/area/loopstation/engineering/telecomms
	name = "Loop Station Telecommunications"
	icon_state = "tcomsatcham"

/area/loopstation/engineering/power
	name = "Loop Station Power Room"
	icon_state = "engine_smes"

/area/loopstation/engineering/gravity
	name = "Loop Station Gravity Room"
	icon_state = "grav_gen"

/area/loopstation/radshelter
	name = "Loop Station Radiation Shelter"
	icon_state = "radstorm_shelter"

/area/loopstation/solars
	icon_state = "panels"
	requires_power = FALSE
	area_flags = NO_GRAVITY | EVENT_PROTECTED
	flags_1 = NONE
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_SPACE
	default_gravity = ZERO_GRAVITY
