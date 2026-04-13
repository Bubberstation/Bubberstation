/// Sets every turf in the area to have planetary atmos; which gradually self-corrects.
/obj/effect/planetary_turf_atmos_helper
	name = "planetary turf atmos helper"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = ""
	plane = POINT_PLANE

/obj/effect/planetary_turf_atmos_helper/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/planetary_turf_atmos_helper/LateInitialize()
	var/area/our_area = get_area(src)
	for(var/turf/potential_turf in get_area_turfs(our_area, z))
		if(!potential_turf.density)
			var/turf/open/our_target_turf = potential_turf
			our_target_turf.planetary_atmos = TRUE

	qdel(src)
