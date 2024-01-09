//commenting out the one in "code/modules/religion/rites.dm"

/datum/religion_rites/synthconversion/invoke_effect(mob/living/user, datum/preferences/preferences, atom/religious_tool)
	..()
	if(!ismovable(religious_tool))
		CRASH("[name]'s perform_rite had a movable atom that has somehow turned into a non-movable!")
	var/atom/movable/movable_reltool = religious_tool
	var/mob/living/carbon/human/rite_target
	if(!movable_reltool?.buckled_mobs?.len)
		rite_target = user
	else
		for(var/buckled in movable_reltool.buckled_mobs)
			if(ishuman(buckled))
				rite_target = buckled
				break
	if(!rite_target)
		return FALSE
	if(rite_target.get_bodypart(BODY_ZONE_R_LEG) == /obj/item/bodypart/leg/right/digi)
		rite_target.set_species(/datum/species/android/digi)
	else if(rite_target.get_bodypart(BODY_ZONE_L_LEG) == /obj/item/bodypart/leg/left/digi)
		rite_target.set_species(/datum/species/android/digi)
	else
		rite_target.set_species(/datum/species/android)
	rite_target.visible_message(span_notice("[rite_target] has been converted by the rite of [name]!"))
	return TRUE
