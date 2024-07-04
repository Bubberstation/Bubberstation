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
