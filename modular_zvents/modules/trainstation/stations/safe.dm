/datum/train_station/near_station/abandoned_depo
	name = "Nearstation - Abandoned depo"
	map_path = "_maps/modular_events/trainstation/nearstations/static_abandoned_train_depo.dmm"

/datum/train_station/abandoned_depo
	name = "Abandoned depo"
	map_path = "_maps/modular_events/trainstation/abandoned_train_depo.dm.dmm"
	creator = "Fenysha"
	possible_nearstations = list(/datum/train_station/near_station/abandoned_depo)
	possible_next = list(/datum/train_station/gairen)

	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/gairen
	name = "Gairen city"
	map_path = "_maps/modular_events/trainstation/start_city.dmm"
	creator = "Kierri & Fenysha"
	ambience_sounds = list('modular_zvents/sounds/thefinalstation/piano_loop.ogg' = 33 SECONDS)

	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING | TRAINSTATION_LOCAL_CENTER

/datum/train_station/deep_forest
	name = "Deep forest"
	creator = "Fenysha"

	region = TRAINSTATION_REGION_THUNDRA
	map_path = "_maps/modular_events/trainstation/deep_forest.dmm"
	possible_nearstations = list(/datum/train_station/near_station/static_mountaints)
