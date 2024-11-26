/obj/item/wallframe/holomap
	name = "holomap frame"
	desc = "Used for building holomaps."
	icon = 'modular_zubbers/icons/obj/machines/holomap/stationmap.dmi'
	icon_state = "station_map_unwired"
	result_path = /obj/machinery/holomap/open
	pixel_shift = 32
	custom_materials = list(
		/datum/material/iron = 4000,
		/datum/material/titanium = 2000,
		/datum/material/glass = 2000,
	)

/obj/item/wallframe/holomap/engineering
	name = "engineering holomap frame"
	desc = "Used for building engineering holomaps."
	icon_state = "station_map_engi_unwired"
	result_path = /obj/machinery/holomap/engineering/open
	custom_materials = list(
		/datum/material/iron = 4000,
		/datum/material/titanium = 2000,
		/datum/material/plasma = 6000,
		/datum/material/gold = 2000,
		/datum/material/diamond = 500,
	)
