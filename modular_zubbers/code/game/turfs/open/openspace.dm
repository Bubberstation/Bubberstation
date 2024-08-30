/turf/open/openspace/moonstation
	icon = 'icons/turf/floors/moonchasm.dmi'
	icon_state = "moonchasm-255"
	base_icon_state = "moonchasm"

	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_TURF_CHASM
	canSmoothWith = SMOOTH_GROUP_TURF_CHASM

	baseturfs = /turf/open/openspace/moonstation

/turf/open/openspace/moonstation/Initialize(mapload)
	icon_state = ""
	. = ..()

/turf/open/openspace/moonstation/LateInitialize()
	. = ..()
	var/turf/T = GET_TURF_BELOW(src)
	if(ismineralturf(T))
		var/turf/closed/mineral/M = T
		M.gets_drilled()
