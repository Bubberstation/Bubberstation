/mob/living/proc/get_tf_component()
	var/obj/item/item_loc = loc
	if(!istype(item_loc))
		return FALSE

	var/datum/component/transformation_item/transformation_component = item_loc.GetComponent(/datum/component/transformation_item)
	if(!istype(transformation_component) || (transformation_component.transformed_mob != src))
		return FALSE

	return transformation_component

/mob/living/proc/handle_transformation_ooc_escape()
	var/datum/component/transformation_item/transformation_component = get_tf_component()
	if(!transformation_component)
		return FALSE

	qdel(transformation_component)
	return TRUE

/mob/living/proc/attempt_to_escape_tf()
	var/datum/component/transformation_item/transformation_component = get_tf_component()
	if(!transformation_component)
		return FALSE

	if(!transformation_component.able_to_struggle_out)
		to_chat(src, span_warning("You are unable to struggle out."))
		return FALSE

	to_chat(src, span_notice("You attempt to escape your transformation."))
	if(!do_after(src, 60 SECONDS))
		to_chat(src, span_warning("You fail to escape."))
		return FALSE

	qdel(transformation_component)
	return TRUE

