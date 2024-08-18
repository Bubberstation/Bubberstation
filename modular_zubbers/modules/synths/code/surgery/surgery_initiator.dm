// Override of tg code

/// Does the surgery de-initiation.
/datum/component/surgery_initiator/attempt_cancel_surgery(datum/surgery/the_surgery, mob/living/patient, mob/user)
	var/selected_zone = user.zone_selected

	if(the_surgery.status == 1)
		if(istype(the_surgery, /datum/surgery/robot))
			var/datum/surgery/robot/robot_surgery = the_surgery
			if(robot_surgery.is_closer)
				patient.balloon_alert(user, "already closing the surgery!")
				return
		patient.surgeries -= the_surgery
		REMOVE_TRAIT(patient, TRAIT_ALLOWED_HONORBOUND_ATTACK, type)
		user.visible_message(
			span_notice("[user] removes [parent] from [patient]'s [patient.parse_zone_with_bodypart(selected_zone)]."),
			span_notice("You remove [parent] from [patient]'s [patient.parse_zone_with_bodypart(selected_zone)]."),
		)

		patient.balloon_alert(user, "stopped work on [patient.parse_zone_with_bodypart(selected_zone)]")

		qdel(the_surgery)
		return

	var/obj/item/close_tool = user.get_inactive_held_item()
	var/is_robotic = the_surgery.requires_bodypart_type == BODYTYPE_ROBOTIC

	if(!is_robotic)
		if(!close_tool || close_tool.tool_behaviour != TOOL_CAUTERY)
			patient.balloon_alert(user, "need a cautery in your inactive hand to stop the surgery!")
			return

	if(!istype(the_surgery, /datum/surgery/robot))
		if(the_surgery.operated_bodypart)
			the_surgery.operated_bodypart.adjustBleedStacks(-5)

		patient.surgeries -= the_surgery

		REMOVE_TRAIT(patient, TRAIT_ALLOWED_HONORBOUND_ATTACK, ELEMENT_TRAIT(type))

		user.visible_message(
			span_notice("[user] closes [patient]'s [patient.parse_zone_with_bodypart(selected_zone)] with [close_tool] and removes [parent]."),
			span_notice("You close [patient]'s [patient.parse_zone_with_bodypart(selected_zone)] with [close_tool] and remove [parent]."),
		)

		patient.balloon_alert(user, "closed up [patient.parse_zone_with_bodypart(selected_zone)]")
	else
		var/datum/surgery/robot/robot_surgery = the_surgery
		if(robot_surgery.status >= robot_surgery.num_steps_until_closing || robot_surgery.is_closer)
			patient.balloon_alert(user, "already closing the surgery!")
			return
		else
			patient.surgeries -= the_surgery

			var/datum/surgery/robot/close_surgery = new robot_surgery.close_surgery(patient, selected_zone, the_surgery.operated_bodypart)
			close_surgery.status += max(robot_surgery.num_opening_steps - robot_surgery.status + 1, 0)

			user.visible_message(
				span_notice("[user] begins to close [patient]'s [patient.parse_zone_with_bodypart(selected_zone)]."),
				span_notice("You begin to close [patient]'s [patient.parse_zone_with_bodypart(selected_zone)]."),
			)

			patient.balloon_alert(user, "began to close up [patient.parse_zone_with_bodypart(selected_zone)]")

	qdel(the_surgery)
