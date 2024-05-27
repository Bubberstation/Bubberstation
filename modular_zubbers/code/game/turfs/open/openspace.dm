//Stolen from glass floor code.

/turf/open/chasm/moonstation

	name = "moon chasm"
	baseturfs = /turf/open/chasm/moonstation

	icon = 'icons/turf/floors/moonchasm.dmi'
	icon_state = "moonchasm-255"
	base_icon_state = "moonchasm"

	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

/turf/open/chasm/moonstation/Initialize(mapload)
	icon_state = ""
	..()
	return INITIALIZE_HINT_LATELOAD

/turf/open/chasm/moonstation/LateInitialize()
	AddElement(/datum/element/turf_z_transparency)
	var/turf/T = GET_TURF_BELOW(src)
	if(ismineralturf(T))
		var/turf/closed/mineral/M = T
		M.gets_drilled()