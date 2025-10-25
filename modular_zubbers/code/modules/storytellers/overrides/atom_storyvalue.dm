// Personalized story value calculation per-atom for storyteller

/atom/proc/story_value()
	// Base atoms: value from materials; for turfs/mobs overridden below
	var/base = story_value_materials(src)
	return base

/obj/item/story_value()
	var/val = story_value_item_credit(src)
	if(val)
		return val
	return max(1, story_value_materials(src))

/obj/machinery/story_value()
	// Machinery has operational importance; add a small baseline on top of mats
	return max(5, story_value_materials(src))

/obj/structure/story_value()
	return max(2, story_value_materials(src))

/turf/story_value()
	// Turfs typically have negligible direct value
	return STORY_VALUE_BASE_TURF

/mob/story_value()
	return STORY_VALUE_BASE_MOB

/mob/living/carbon/story_value()
	return STORY_VALUE_BASE_CARBON


/proc/story_value_item_credit(obj/item/I)
	if(isnull(I) || QDELETED(I))
		return 0
	var/val = I.get_item_credit_value()
	return max(0, val)

/atom/proc/story_value_materials(atom/A)
	if(isnull(A) || QDELETED(A))
		return 0
	if(!length(A.custom_materials))
		return 0
	var/total = 0
	var/list/mat_effects = A.get_material_effects_list(A.custom_materials)
	if(!islist(mat_effects) || !length(mat_effects))
		return 0
	for(var/datum/material/mat as anything in mat_effects)
		var/list/deets = mat_effects[mat]
		var/amt = deets[MATERIAL_LIST_OPTIMAL_AMOUNT]
		total += (initial(mat.value_per_unit) || 0) * (amt || 0)
	return max(0, total)

