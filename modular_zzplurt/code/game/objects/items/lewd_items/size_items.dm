/obj/item/clothing/neck/size_collar
	warning_given = TRUE //don't ruin the fun

/datum/component/temporary_size
	allowed_areas = list() //Allow for use anywhere

/datum/component/temporary_size/apply_size(size_to_apply)
	. = ..()

	if(.)
		adjust_mobsize(size_to_apply)
