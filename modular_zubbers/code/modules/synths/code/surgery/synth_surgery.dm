/datum/surgery/robot
	var/name = "robot surgery"
	var/num_opening_steps
	var/num_steps_until_closing
	var/close_surgery
	var/is_closer = FALSE

//reattach plating
/datum/surgery_step/reattach_plating
	name = "reattach plating (crowbar)"
	implements = list(
		TOOL_CROWBAR = 100,
		TOOL_HEMOSTAT = 10,
	)
	time = 2.4 SECONDS
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/reattach_plating/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to reattach [target]'s [parse_zone(target_zone)] plating..."),
		"[user] begins to reattach [target]'s [parse_zone(target_zone)] plating.",
		"[user] begins to reattach [target]'s [parse_zone(target_zone)] plating.",
	)

/datum/surgery/robot/next_step(mob/living/user, modifiers)
	if(location != user.zone_selected)
		return FALSE
	if(user.combat_mode)
		return FALSE
	if(step_in_progress)
		return TRUE

	var/try_to_fail = FALSE
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		try_to_fail = TRUE

	var/datum/surgery_step/step = get_surgery_step()
	if(isnull(step))
		return FALSE
	var/obj/item/tool = user.get_active_held_item()
	if(step.try_op(user, target, user.zone_selected, tool, src, try_to_fail))
		return TRUE
	if(tool && (tool.tool_behaviour in MECHANICAL_TOOLS)) //Mechanic surgery should be done with mechanical tools
		to_chat(user, span_warning("This step requires a different tool!"))
		return TRUE

	return FALSE

/datum/surgery/robot/advanced
	name = "advanced robot surgery"
	requires_tech = TRUE
