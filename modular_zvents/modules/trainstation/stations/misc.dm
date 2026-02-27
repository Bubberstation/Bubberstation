/datum/train_station/near_station/static_default
	name = "Nearstation static - Default"
	map_path = "_maps/modular_events/trainstation/nearstations/static_default.dmm"

/datum/train_station/near_station/static_mountaints
	name = "Nearstation static - Default"
	map_path = "_maps/modular_events/trainstation/nearstations/static_mountains.dmm"


/datum/train_station/near_station/moving_default
	name = "Nearstation - Forest outskirts"
	map_path = "_maps/modular_events/trainstation/nearstations/moving_default.dmm"

/datum/train_station/near_station/moving_deepforerst
	name = "Nearstation - Deep forest"
	map_path = "_maps/modular_events/trainstation/nearstations/moving_deep_forest.dmm"


/datum/train_station/train_backstage
	name = "Iced forest"
	map_path = "_maps/modular_events/trainstation/backstage.dmm"
	station_flags = TRAINSTATION_ABSCTRACT | TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION
	visible = FALSE
	possible_nearstations = list(/datum/train_station/near_station/moving_default)

/datum/train_station/cargo_station
	name = "Cargo station"
	map_path = "_maps/modular_events/trainstation/cargo_station.dmm"
	station_flags = TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION
	region = TRAINSTATION_REGION_THUNDRA
	station_type = TRAINSTATION_TYPE_CARGO
	visible = TRUE
	required_password = FALSE
	required_stations = 0
	maximum_visits = INFINITY
	threat_level = THREAT_LEVEL_SAFE
	creator = "Fenysha"
