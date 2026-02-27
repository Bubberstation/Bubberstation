/datum/train_station/near_station/abandoned_depo
	name = "Nearstation - Abandoned depo"
	map_path = "_maps/modular_events/trainstation/nearstations/static_abandoned_train_depo.dmm"

/datum/train_station/abandoned_depo
	name = "Gairen train depot"
	desc = "The evacuated railway depot located in the vicinity of the city of Gairen \
			is located directly behind the factory that manufactures modern trains. "
	map_path = "_maps/modular_events/trainstation/abandoned_train_depo.dm.dmm"
	creator = "Fenysha"
	possible_nearstations = list(/datum/train_station/near_station/abandoned_depo)
	possible_next = list(/datum/train_station/gairen)

	region = TRAINSTATION_REGION_THUNDRA
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/gairen
	name = "Gairen city"
	desc = "Gairen is an industrial city located in the north of the country. \
			It is an industrial center and has many factories on its territory. \
			Unfortunately, the city has been experiencing difficult times recently."
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
