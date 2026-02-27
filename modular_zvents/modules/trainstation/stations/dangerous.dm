/datum/train_station/emergency_station_a13
	name = "Emergency station A13"
	map_path = "_maps/modular_events/trainstation/emergency_a13.dmm"
	creator = "Fenysha"
	visible = FALSE

	threat_level = THREAT_LEVEL_RISKY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/infected_laboratory
	name = "Gaizhin city"
	map_path = "_maps/modular_events/trainstation/infected_lab.dmm"
	creator = "Fenysha & v1s1ti"

	threat_level = THREAT_LEVEL_DANGEROUS
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING | TRAINSTATION_LOCAL_CENTER

/datum/train_station/start_point
	name = "Union Plasa"
	map_path = "_maps/modular_events/trainstation/startpoint.dmm"
	creator = "Fenysha"
	possible_next = list()
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING | TRAINSTATION_FINAL_STATION

	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	required_stations = 8

/datum/train_station/military_house
	name = "Gaizhin evacuated military side"
	creator = "Fenysha & TYWONKA"
	map_path = "_maps/modular_events/trainstation/military_side.dmm"

	threat_level = THREAT_LEVEL_DANGEROUS
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/missle_military_side
	name = "Corrupted military Side"
	creator = "v1s1ti"
	map_path = "_maps/modular_events/trainstation/missle_military_side.dmm"

	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 6

/datum/train_station/warehouses
	name = "Abandoned warehousess"
	creator = "Fenysha & TYWONKA"
	map_path = "_maps/modular_events/trainstation/warehouse.dmm"

	threat_level = THREAT_LEVEL_RISKY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING


/datum/train_station/near_station/lost_dam
	name = "Nearstation - Lost dam"
	map_path = "_maps/modular_events/trainstation/nearstations/static_lost_dam.dmm"

/datum/train_station/lost_dam
	name = "Lost dam"
	creator = "Mold & Fenysha"

	threat_level = THREAT_LEVEL_HAZARDOUS
	region = TRAINSTATION_REGION_THUNDRA
	map_path = "_maps/modular_events/trainstation/lost_dam.dmm"
	possible_nearstations = list(/datum/train_station/near_station/lost_dam)

/datum/train_station/mines
	name = "Abandoned mines"
	creator = "Kierri"
	map_path = "_maps/modular_events/trainstation/abandoned_mines.dmm"

	threat_level = THREAT_LEVEL_RISKY
	region = TRAINSTATION_REGION_THUNDRA
	possible_nearstations = list(/datum/train_station/near_station/static_mountaints)
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/collapsed_lab
	name = "Collapsed laboratory"
	creator = "Mold & Fenysha"
	map_path = "_maps/modular_events/trainstation/collapsed_lab.dmm"

	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 5

/datum/train_station/radiosphere
	name = "The Radiosphere"
	creator = "Fenysha & Mold"
	map_path = "_maps/modular_events/trainstation/radiosphere.dmm"

	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 5

	ambience_sounds = list('modular_zvents/sounds/radiosphere_loop1.ogg' = 40 SECONDS)
