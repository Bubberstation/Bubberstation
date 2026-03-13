/datum/train_station/emergency_station_a13
	name = "Emergency station A13"
	desc = "An emergency military station without any identifying marks. \
			It seems that trains cannot stop there under normal circumstances."
	map_path = "_maps/modular_events/trainstation/emergency_a13.dmm"
	creator = "Fenysha"
	visible = FALSE

	station_type = TRAINSTATION_TYPE_MILITARY
	threat_level = THREAT_LEVEL_RISKY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/infected_laboratory
	name = "Gaizhin city"
	map_path = "_maps/modular_events/trainstation/infected_lab.dmm"
	desc = "A large city with a population of over one and a half million people. \
			It is home to numerous research institutes belonging to various corporations. \
			Its radio beacon broadcasting about the evacuation that has begun."
	creator = "Fenysha & v1s1ti"

	station_type = TRAINSTATION_TYPE_CITY
	threat_level = THREAT_LEVEL_DANGEROUS
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING | TRAINSTATION_LOCAL_CENTER

/datum/train_station/start_point
	name = "Union Plasa"
	map_path = "_maps/modular_events/trainstation/startpoint.dmm"
	creator = "Fenysha"
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING | TRAINSTATION_FINAL_STATION
	desc = "A large research laboratory located near a densely populated city. \
			The main institute for research into the Khara disease. The final station."


	station_type = TRAINSTATION_TYPE_MILITARY
	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	required_stations = 8

/datum/train_station/military_house
	name = "Gaizhin military side"
	creator = "Fenysha & TYWONKA"
	map_path = "_maps/modular_events/trainstation/military_side.dmm"
	desc = "The military base belonging to the city of Gaizhin, \
			its radio beacon broadcasting about the evacuation that has begun."

	station_type = TRAINSTATION_TYPE_MILITARY
	threat_level = THREAT_LEVEL_DANGEROUS
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/missle_military_side
	name = "Roseville military Side"
	creator = "v1s1ti & Fenysha"
	map_path = "_maps/modular_events/trainstation/missle_military_side.dmm"
	desc = "The large military base located near the town of Roseville is one of the largest military bases in the region. \
			Several missile divisions are based there. Its radio beacon broadcasting about the evacuation that has begun."

	station_type = TRAINSTATION_TYPE_MILITARY
	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING | TRAINSTATION_LOCAL_CENTER


/datum/train_station/warehouses
	name = "Abandoned warehousess"
	creator = "Fenysha & TYWONKA"
	map_path = "_maps/modular_events/trainstation/warehouse.dmm"
	desc = "Abandoned warehouses with a small station located next to them. \
			Radio beacon - does not transmit any signals."

	threat_level = THREAT_LEVEL_RISKY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING


/datum/train_station/near_station/lost_dam
	name = "Nearstation - Lost dam"
	map_path = "_maps/modular_events/trainstation/nearstations/static_lost_dam.dmm"

/datum/train_station/lost_dam
	name = "Penrose dam"
	creator = "Mold & Fenysha"
	desc = "A large hydroelectric power station located in the vicinity of the city of Penrose. \
			The radio beacon is active, indicating that the structure is still operational."

	threat_level = THREAT_LEVEL_HAZARDOUS
	region = TRAINSTATION_REGION_THUNDRA
	map_path = "_maps/modular_events/trainstation/lost_dam.dmm"
	possible_nearstations = list(/datum/train_station/near_station/lost_dam)

/datum/train_station/mines
	name = "Abandoned mines"
	creator = "Kierri"
	map_path = "_maps/modular_events/trainstation/abandoned_mines.dmm"
	desc = "An abandoned array of mines and caves, the radio beacon station is not transmitting any signals."

	threat_level = THREAT_LEVEL_RISKY
	region = TRAINSTATION_REGION_THUNDRA
	possible_nearstations = list(/datum/train_station/near_station/static_mountaints)
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/collapsed_lab
	name = "Unidentified structure"
	creator = "Mold & Fenysha"
	map_path = "_maps/modular_events/trainstation/collapsed_lab.dmm"
	desc = "The satellites were unable to identify the structure. \
			The radio beacon is transmitting an SOS signal."

	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 5

/datum/train_station/radiosphere
	name = "Massive structure"
	creator = "Fenysha & Mold"
	map_path = "_maps/modular_events/trainstation/radiosphere.dmm"
	desc = "The satellites were unable to identify the structure. \
			Strong radio interference is detected."

	threat_level = THREAT_LEVEL_DEADLY
	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 5

	ambience_sounds = list('modular_zvents/sounds/radiosphere_loop1.ogg' = 40 SECONDS)
