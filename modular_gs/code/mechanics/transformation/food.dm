/obj/item/reagent_containers/food/snacks/proc/handle_tf(mob/living/eater)
	var/datum/component/transformation_item/transformation_component = GetComponent(/datum/component/transformation_item)
	if(!istype(transformation_component) || transformation_component.transfer_to_vore || (transformation_component.transformed_mob != src))
		return FALSE

	var/mob/living/food_mob = transformation_component.transformed_mob
	var/obj/belly/vore_belly = eater?.vore_selected
	if(!istype(food_mob) || !(food_mob?.vore_flags & DEVOURABLE) || (eater?.vore_flags & NO_VORE) || !istype(vore_belly))
		return FALSE

	qdel(transformation_component)
	if(!vore_belly?.nom_mob(food_mob,eater))
		return FALSE

	return TRUE

