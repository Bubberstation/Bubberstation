/turf/open/chasm/gas_giant
	name = "\proper gas giant stratosphere"
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock_highchance"
	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT // Look I get the appeal is that this is a space oil rig; but come on. The poor CPU...
	initial_gas_mix = GASGIANT_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/chasm/gas_giant
	light_range = 1.9
	light_power = 0.65
	light_color = LIGHT_COLOR_BROWN
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	plane = PLANE_SPACE
	layer = SPACE_LAYER

/turf/open/chasm/gas_giant/apply_components(mapload)
	AddComponent(/datum/component/chasm/gas_giant, GET_TURF_BELOW(src), mapload) // Drops you off at medbay after killing you DEAD
