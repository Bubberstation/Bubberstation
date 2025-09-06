/*
// Unlike drains which slowly delete liquids; water turfs INSTANTLY kill any liquids that come in contact with them
// This creates some weird edgecases on /tg/ maps but I vastly prefer it behave like this
/turf/open/water/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TURF_LIQUIDS_CHANGE, PROC_REF(kill_liquid_kill))
	RegisterSignal(src, COMSIG_TURF_LIQUIDS_CREATION, PROC_REF(kill_liquid_kill))

/turf/open/water/ChangeTurf(path, list/new_baseturfs, flags)
	UnregisterSignal(src, COMSIG_TURF_LIQUIDS_CHANGE)
	UnregisterSignal(src, COMSIG_TURF_LIQUIDS_CREATION)
	return ..()

/turf/open/water/proc/kill_liquid_kill()
	if(liquids)
		liquids.liquid_simple_delete_flat(INFINITY)
*/
/turf/open/water/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(.)
		return TRUE

	if(istype(W, /obj/item/stack/rods))
		build_with_rods(W, user)
		return TRUE
	else if(istype(W, /obj/item/stack/tile/iron))
		build_with_floor_tiles(W, user)
		return TRUE


/turf/open/water/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_TURF)
		if(the_rcd.rcd_design_path != /turf/open/floor/plating/rcd)
			return FALSE

		return list("delay" = 0, "cost" = 3)
	return FALSE

/turf/open/water/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(rcd_data["[RCD_DESIGN_MODE]"] == RCD_TURF)
		if(rcd_data["[RCD_DESIGN_PATH]"] != /turf/open/floor/plating/rcd)
			return FALSE

		place_on_top(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	return FALSE
