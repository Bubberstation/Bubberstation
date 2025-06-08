//GLOBAL_LIST_INIT(uncapped_resize_areas, list(/area/command/bridge, /area/maintenance, /area/security/prison, /area/holodeck, /area/commons/vacant_room/office, /area/space, /area/ruin, /area/lavaland, /area/awaymission, /area/centcom, /area/fatlab, /area/xenoarch))

/mob/living/carbon/proc/xwg_resize()
	return TRUE // code in later
/*
	if(client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_extreme && !normalized))
		var/xwg_size = sqrt(fatness/FATNESS_LEVEL_BLOB)
		xwg_size = min(xwg_size, RESIZE_MACRO)
		xwg_size = max(xwg_size, custom_body_size)
		if(xwg_size > RESIZE_A_HUGEBIG) //check if the size needs capping otherwise don't bother searching the list
			if(!is_type_in_list(get_area(src), GLOB.uncapped_resize_areas)) //if the area is not int the uncapped whitelist and new size is over the cap
				xwg_size = RESIZE_A_HUGEBIG
		resize(xwg_size)
*/
