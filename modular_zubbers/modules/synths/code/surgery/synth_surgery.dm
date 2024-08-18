/datum/surgery/robot
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
	preop_sound = 'sound/items/crowbar_prying.ogg'
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/reattach_plating/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to reattach [target]'s [parse_zone(target_zone)] plating..."),
		"[user] begins to reattach [target]'s [parse_zone(target_zone)] plating.",
		"[user] begins to reattach [target]'s [parse_zone(target_zone)] plating.",
	)
