// Override of tg code

/datum/component/surgery_initiator/get_available_surgeries(mob/user, mob/living/target)
	var/list/available_surgeries = list()

	var/mob/living/carbon/carbon_target
	var/obj/item/bodypart/affecting
	if (iscarbon(target))
		carbon_target = target
		affecting = carbon_target.get_bodypart(check_zone(user.zone_selected))

	for(var/datum/surgery/surgery as anything in GLOB.surgeries_list)
		if(!surgery.possible_locs.Find(user.zone_selected))
			continue
		if(affecting)
			if(!(surgery.surgery_flags & SURGERY_REQUIRE_LIMB))
				continue
			if(surgery.requires_bodypart_type && !(affecting.bodytype & surgery.requires_bodypart_type))
				continue
			if((surgery.surgery_flags & SURGERY_REQUIRES_REAL_LIMB) && (affecting.bodypart_flags & BODYPART_PSEUDOPART))
				continue
		else if(carbon_target && (surgery.surgery_flags & SURGERY_REQUIRE_LIMB)) //mob with no limb in surgery zone when we need a limb
			continue
		if(IS_IN_INVALID_SURGICAL_POSITION(target, surgery))
			continue
		if(!surgery.can_start(user, target))
			continue
		if(istype(surgery, /datum/surgery/robot))
			var/datum/surgery/robot/robot_surgery = surgery
			if(robot_surgery.is_closer)
				continue
		for(var/path in surgery.target_mobtypes)
			if(istype(target, path))
				available_surgeries += surgery
				break

	return available_surgeries

/// Does the surgery de-initiation.
/datum/component/surgery_initiator/attempt_cancel_surgery(datum/surgery/the_surgery, mob/living/patient, mob/user)
	var/selected_zone = user.zone_selected

	if(the_surgery.status == 1)
		if(istype(the_surgery, /datum/surgery/robot))
			var/datum/surgery/robot/robot_surgery = the_surgery
			if(robot_surgery.is_closer)
				user.balloon_alert("already closing the surgery!")
				return
		patient.surgeries -= the_surgery
		REMOVE_TRAIT(patient, TRAIT_ALLOWED_HONORBOUND_ATTACK, type)
		user.visible_message(
			span_notice("[user] removes [parent] from [patient]'s [parse_zone(selected_zone)]."),
			span_notice("You remove [parent] from [patient]'s [parse_zone(selected_zone)]."),
		)

		patient.balloon_alert(user, "stopped work on [parse_zone(selected_zone)]")

		qdel(the_surgery)
		return

	var/required_tool_type = TOOL_CAUTERY
	var/obj/item/close_tool = user.get_inactive_held_item()
	var/is_robotic = the_surgery.requires_bodypart_type == BODYTYPE_ROBOTIC

	if(!is_robotic)
		if(iscyborg(user))
			close_tool = locate(/obj/item/cautery) in user.held_items
			if(!close_tool)
				patient.balloon_alert(user, "need a cautery in an inactive slot to stop the surgery!")
				return
		else if(!close_tool || close_tool.tool_behaviour != required_tool_type)
			patient.balloon_alert(user, "need a cautery in your inactive hand to stop the surgery!")
			return

	if(!istype(the_surgery, /datum/surgery/robot))
		patient.surgeries -= the_surgery

		if(the_surgery.operated_bodypart)
			the_surgery.operated_bodypart.adjustBleedStacks(-5)

		REMOVE_TRAIT(patient, TRAIT_ALLOWED_HONORBOUND_ATTACK, ELEMENT_TRAIT(type))

		user.visible_message(
			span_notice("[user] closes [patient]'s [parse_zone(selected_zone)] with [close_tool] and removes [parent]."),
			span_notice("You close [patient]'s [parse_zone(selected_zone)] with [close_tool] and remove [parent]."),
		)

		patient.balloon_alert(user, "closed up [parse_zone(selected_zone)]")

		qdel(the_surgery)
	else
		var/datum/surgery/robot/robot_surgery = the_surgery
		if(robot_surgery.status >= robot_surgery.num_steps_until_closing || robot_surgery.is_closer)
			user.balloon_alert("already closing the surgery!")
		else
			patient.surgeries -= the_surgery

			var/datum/surgery/robot/close_surgery = new robot_surgery.close_surgery(patient, selected_zone, the_surgery.operated_bodypart)
			close_surgery.status += max(robot_surgery.num_opening_steps - robot_surgery.status + 1, 0)

			user.visible_message(
				span_notice("[user] begins to close [patient]'s [parse_zone(selected_zone)]."),
				span_notice("You begin to close [patient]'s [parse_zone(selected_zone)]."),
			)

			patient.balloon_alert(user, "began to close up [parse_zone(selected_zone)]")

			qdel(the_surgery)
