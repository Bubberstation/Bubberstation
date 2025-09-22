//GLOBAL_LIST_INIT(uncapped_resize_areas, list(/area/command/bridge, /area/maintenance, /area/security/prison, /area/holodeck, /area/commons/vacant_room/office, /area/space, /area/ruin, /area/lavaland, /area/awaymission, /area/centcom, /area/fatlab, /area/xenoarch))

/mob/living/carbon/proc/xwg_resize()
	if(!ishuman(src) || !client?.prefs.read_preference(/datum/preference/toggle/weight_size_scaling))
		return FALSE

	if(!GetComponent(/datum/component/temporary_size/xwg))
		AddComponent(/datum/component/temporary_size/xwg)

	SEND_SIGNAL(src, COMSIG_WEIGHT_ADJUSTED)
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
/datum/component/temporary_size/xwg

/datum/component/temporary_size/xwg/Initialize(size_to_apply)
	. = ..()

	RegisterSignal(parent, COMSIG_WEIGHT_ADJUSTED, PROC_REF(recalculate_weight_size))
	UnregisterSignal(parent, COMSIG_ENTER_AREA)
	RegisterSignal(parent, COMSIG_ENTER_AREA, PROC_REF(check_area))

/datum/component/temporary_size/xwg/proc/recalculate_weight_size()
	SIGNAL_HANDLER

	var/mob/living/carbon/human/human_parent = parent
	if(!istype(human_parent))
		return FALSE

	if(!human_parent?.client?.prefs.read_preference(/datum/preference/toggle/weight_size_scaling))
		return FALSE

	var/max_size = RESIZE_BIG
	if(human_parent?.client?.prefs.read_preference(/datum/preference/toggle/size_xwg))
		max_size = RESIZE_MACRO

	target_size = sqrt(human_parent.fatness/FATNESS_LEVEL_BLOB)
	target_size = max(target_size, original_size)
	target_size = min(target_size, max_size)


	check_area()

/datum/component/temporary_size/xwg/check_area()
	var/area/current_area = get_area(parent)
	var/size_max = RESIZE_BIG

	if(!length(allowed_areas) || is_type_in_list(current_area, allowed_areas))
		size_max = RESIZE_MACRO

	var/size_to_apply = min(target_size, size_max)
	apply_size(size_to_apply)

	return TRUE
