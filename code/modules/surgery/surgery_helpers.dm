// BUBBER EDIT CHANGE BEGIN - Surgery Modifiers
/*
/*
 * Gets the surgery speed modifier for a given mob, based off what sort of table/bed/whatever is on their turf.
 */
/proc/get_location_modifier(mob/located_mob)
	// Technically this IS a typecache, just not the usual kind :3
	var/static/list/modifiers = zebra_typecacheof(list(
		/obj/structure/table = 0.8,
		/obj/structure/table/optable = 1,
		/obj/structure/table/optable/abductor = 1.2,
		/obj/machinery/stasis = 0.9,
		/obj/structure/bed = 0.7,
	))
	. = 0.5
	for(var/obj/thingy in get_turf(located_mob))
		. = max(., modifiers[thingy.type])
*/

/proc/get_location_modifier(mob/located_mob)
	var/turf/mob_turf = get_turf(located_mob)
	var/obj/structure/table/optable/operating_table = locate(/obj/structure/table/optable, mob_turf)
	if(!isnull(operating_table))
		if(operating_table.computer?.is_operational)
			return OPERATING_COMPUTER_MODIFIER
		else
			return 1
	else if(locate(/obj/structure/bed/medical, mob_turf))
		return 0.9
	else if(locate(/obj/structure/bed/medical/emergency, mob_turf))
		return 0.9
	else if(locate(/obj/machinery/stasis, mob_turf))
		return 0.7
	else if(locate(/obj/structure/table, mob_turf))
		return 0.6
	else if(locate(/obj/structure/bed, mob_turf))
		return 0.6
	else
		return 0.5
// BUBBER EDIT CHANGE END


/proc/get_location_accessible(mob/located_mob, location)
	var/covered_locations = 0 //based on body_parts_covered
	var/face_covered = 0 //based on flags_inv
	var/eyesmouth_covered = 0 //based on flags_cover
	if(iscarbon(located_mob))
		var/mob/living/carbon/clothed_carbon = located_mob
		for(var/obj/item/clothing/clothes in list(clothed_carbon.back, clothed_carbon.wear_mask, clothed_carbon.head))
			covered_locations |= clothes.body_parts_covered
			face_covered |= clothes.flags_inv
			eyesmouth_covered |= clothes.flags_cover
		if(ishuman(clothed_carbon))
			var/mob/living/carbon/human/clothed_human = clothed_carbon
			for(var/obj/item/clothes in list(clothed_human.wear_suit, clothed_human.w_uniform, clothed_human.shoes, clothed_human.belt, clothed_human.gloves, clothed_human.glasses, clothed_human.ears))
				covered_locations |= clothes.body_parts_covered
				face_covered |= clothes.flags_inv
				eyesmouth_covered |= clothes.flags_cover

	switch(location)
		if(BODY_ZONE_HEAD)
			if(covered_locations & HEAD)
				return FALSE
		if(BODY_ZONE_PRECISE_EYES)
			if((face_covered & HIDEEYES) || (eyesmouth_covered & (MASKCOVERSEYES|HEADCOVERSEYES|GLASSESCOVERSEYES)))
				return FALSE
		if(BODY_ZONE_PRECISE_MOUTH)
			if((face_covered & HIDEFACE) || (eyesmouth_covered & (MASKCOVERSMOUTH|HEADCOVERSMOUTH)))
				return FALSE
		if(BODY_ZONE_CHEST)
			if(covered_locations & CHEST)
				return FALSE
		if(BODY_ZONE_PRECISE_GROIN)
			if(covered_locations & GROIN)
				return FALSE
		if(BODY_ZONE_L_ARM)
			if(covered_locations & ARM_LEFT)
				return FALSE
		if(BODY_ZONE_R_ARM)
			if(covered_locations & ARM_RIGHT)
				return FALSE
		if(BODY_ZONE_L_LEG)
			if(covered_locations & LEG_LEFT)
				return FALSE
		if(BODY_ZONE_R_LEG)
			if(covered_locations & LEG_RIGHT)
				return FALSE
		if(BODY_ZONE_PRECISE_L_HAND)
			if(covered_locations & HAND_LEFT)
				return FALSE
		if(BODY_ZONE_PRECISE_R_HAND)
			if(covered_locations & HAND_RIGHT)
				return FALSE
		if(BODY_ZONE_PRECISE_L_FOOT)
			if(covered_locations & FOOT_LEFT)
				return FALSE
		if(BODY_ZONE_PRECISE_R_FOOT)
			if(covered_locations & FOOT_RIGHT)
				return FALSE

	return TRUE
