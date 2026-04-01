#define DAMAGE_ROUNDING 0.1
#define FAIL_DAMAGE_MULTIPLIER 0.8
#define FINAL_STEP_HEAL_MULTIPLIER 0.55

//Almost copypaste of tend wounds, with some changes
/datum/surgery/robot_healing
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/cut_wires,
		/datum/surgery_step/robot_heal,
		/datum/surgery_step/mechanic_close,
	)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	replaced_by = /datum/surgery
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_IGNORE_CLOTHES | SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_SELF_OPERABLE

	/// The step to use in the 4th surgery step.
	var/healing_step_type
	/// If true, doesn't send the surgery preop message. Set during surgery.
	var/surgery_preop_message_sent = FALSE

/datum/surgery/robot_healing/New(surgery_target, surgery_location, surgery_bodypart)
	..()
	if(healing_step_type)
		steps = list(
			/datum/surgery_step/mechanic_open,
			/datum/surgery_step/pry_off_plating,
			/datum/surgery_step/cut_wires,
			healing_step_type,
			/datum/surgery_step/mechanic_close,
		)

/datum/surgery_step/robot_heal
	name = "repair body (crowbar/wirecutters)"
	implements = list(TOOL_CROWBAR = 100, TOOL_WIRECUTTER = 100)
	repeatable = TRUE
	time = 2.7 SECONDS

	/// If this surgery is healing brute damage. Set during operation steps.
	var/heals_brute = FALSE
	/// If this surgery is healing burn damage. Set during operation steps.
	var/heals_burn = FALSE
	/// How much healing the sugery gives.
	var/brute_heal_amount = 7
	/// How much healing the sugery gives.
	var/burn_heal_amount = 7
	/// Percentage of total damaged healed per cycle. If 0, no healing of the damage is performed
	var/brute_multiplier = 0
	/// Percentage of total damaged healed per cycle. If 0, no healing of the damage is performed
	var/burn_multiplier = 0

/datum/surgery_step/robot_heal/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_CROWBAR && implement_type == TOOL_WIRECUTTER)
		return FALSE
	return TRUE

/datum/surgery_step/robot_heal/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/woundtype
	if(implement_type == TOOL_CROWBAR)
		heals_brute = TRUE
		heals_burn = FALSE
		woundtype = "dents"
		return

	if(implement_type == TOOL_WIRECUTTER)
		heals_brute = FALSE
		heals_burn = TRUE
		woundtype = "wiring"
		return

	if(!istype(surgery, /datum/surgery/robot_healing))
		return

	var/datum/surgery/robot_healing/the_surgery = surgery
	if(the_surgery.surgery_preop_message_sent)
		return

	display_results(
		user,
		target,
		span_notice("You attempt to fix some of [target]'s [woundtype]."),
		span_notice("[user] attempts to fix some of [target]'s [woundtype]."),
		span_notice("[user] attempts to fix some of [target]'s [woundtype]."),
	)

/datum/surgery_step/robot_heal/initiate(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	if(..())
		while((heals_brute && target.get_brute_loss() && tool) || (heals_burn && target.get_fire_loss() && tool))
			if(!..())
				break

/datum/surgery_step/robot_heal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/user_message = "You succeed in fixing some of [target]'s damage" //no period, add initial space to "addons"
	var/target_message = "[user] fixes some of [target]'s damage" //see above
	var/brute_healed = 0
	var/burn_healed = 0
	var/status_msg = list()
	feedback_value = null
	if(heals_brute)
		brute_healed = brute_heal_amount
		tool.use_tool(target, user, 0, volume = 50, amount = 1)
		brute_healed += round((target.get_brute_loss() * brute_multiplier), DAMAGE_ROUNDING)

	if(heals_burn)
		burn_healed = burn_heal_amount
		tool.use_tool(target, user, 0, volume = 50, amount = 1)
		burn_healed += round((target.get_fire_loss() * burn_multiplier), DAMAGE_ROUNDING)

	if(!get_location_accessible(target, target_zone))
		brute_healed *= FINAL_STEP_HEAL_MULTIPLIER
		burn_healed *= FINAL_STEP_HEAL_MULTIPLIER
		status_msg += "[target.p_have()] clothing on"

	if(length(status_msg) > 0)
		user_message += " as best as you can while [target.p_they()] [english_list(status_msg)]"
		target_message += " as best as [user.p_they()] can while [target.p_they()] [english_list(status_msg)]"

	feedback_value = brute_healed + burn_healed

	target.heal_bodypart_damage(brute_healed, burn_healed, updating_health = FALSE)

	if(!get_feedback_message(user, target))
		user_message += get_progress(user, target, brute_healed, burn_healed)

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID) && ishuman(user) && target.stat != DEAD) //Morbid folk don't care about tending the dead as much as tending the living
		var/mob/living/carbon/human/morbid_weirdo = user
		morbid_weirdo.add_mood_event("morbid_tend_wounds", /datum/mood_event/morbid_tend_wounds)

	display_results(
		user,
		target,
		span_notice("[user_message]."),
		span_notice("[target_message]."),
		span_notice("[target_message]."),
	)

	if(istype(surgery, /datum/surgery/robot_healing))
		var/datum/surgery/robot_healing/the_surgery = surgery
		the_surgery.surgery_preop_message_sent = TRUE

	return TRUE

/datum/surgery_step/robot_heal/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_warning("You screwed up!"),
		span_warning("[user] screws up!"),
		span_notice("[user] fixes some of [target]'s damage."),
		target_detailed = TRUE,
	)

	var/brute_dealt = 0
	var/burn_dealt = 0
	if(heals_brute)
		brute_dealt = brute_heal_amount * FAIL_DAMAGE_MULTIPLIER
		brute_dealt += round((target.get_brute_loss() * (brute_multiplier * 0.5)), DAMAGE_ROUNDING)

	if(heals_burn)
		burn_dealt = burn_heal_amount * FAIL_DAMAGE_MULTIPLIER
		burn_dealt += round((target.get_fire_loss() * (burn_multiplier * 0.5)), DAMAGE_ROUNDING)

	target.take_bodypart_damage(brute_dealt, burn_dealt, wound_bonus = CANT_WOUND)
	return FALSE

/***************************TYPES***************************/
/datum/surgery/robot_healing/basic
	name = "Repair Robotic Chassis (Basic)"
	desc = "A surgical procedure that provides repairs and maintenance to robotic chassis. Is slightly more efficient when the patient is severely damaged."
	healing_step_type = /datum/surgery_step/robot_heal/basic
	replaced_by = /datum/surgery/robot_healing/upgraded

/datum/surgery/robot_healing/upgraded
	name = "Repair Robotic Chassis (Adv.)"
	desc = "A surgical procedure that provides highly effective repairs and maintenance to robotic chassis. Is somewhat more efficient when the patient is severely damaged."
	healing_step_type = /datum/surgery_step/robot_heal/upgraded
	replaced_by = /datum/surgery/robot_healing/experimental
	requires_tech = TRUE

/datum/surgery/robot_healing/experimental
	name = "Repair Robotic Chassis (Exp.)"
	desc = "A surgical procedure that quickly provides highly effective repairs and maintenance to robotic chassis. Is moderately more efficient when the patient is severely damaged."
	healing_step_type = /datum/surgery_step/robot_heal/experimental
	replaced_by = null
	requires_tech = TRUE

/***************************STEPS***************************/

/datum/surgery_step/robot_heal/basic
	brute_multiplier = 0.07
	burn_multiplier = 0.07

/datum/surgery_step/robot_heal/upgraded
	brute_multiplier = 0.1
	burn_multiplier = 0.1

/datum/surgery_step/robot_heal/experimental
	brute_multiplier = 0.2
	burn_multiplier = 0.2

// Mostly a copypaste of standard tend wounds get_progress(). In order to abstract this, I'd have to rework the hierarchy of surgery upstream, so I'll just do this. Pain.
/**
 * Args:
 * * mob/user: The user performing this surgery.
 * * mob/living/carbon/target: The target of the surgery.
 * * brute_healed: The amount of brute we just healed.
 * * burn_healed: The amount of burn we just healed.
 *
 * Returns:
 * * A string containing either an estimation of how much longer the surgery will take, or exact numbers of the remaining damages, depending on if a health analyzer
 * is held or not.
 */
/datum/surgery_step/robot_heal/proc/get_progress(mob/user, mob/living/carbon/target, brute_healed, burn_healed)
	var/estimated_remaining_steps = 0
	if(brute_healed > 0)
		estimated_remaining_steps = max(0, (target.get_brute_loss() / brute_healed))
	if(burn_healed > 0)
		estimated_remaining_steps = max(estimated_remaining_steps, (target.get_fire_loss() / burn_healed)) // whichever is higher between brute or burn steps

	var/progress_text

	if(locate(/obj/item/healthanalyzer) in user.held_items)
		if(target.get_brute_loss())
			progress_text = ". Remaining brute: <font color='#ff3333'>[target.get_brute_loss()]</font>"
		if(target.get_fire_loss())
			progress_text += ". Remaining burn: <font color='#ff9933'>[target.get_fire_loss()]</font>"
	else
		switch(estimated_remaining_steps)
			if(-INFINITY to 1)
				return
			if(1 to 3)
				progress_text = ", finishing up the last few signs of damage"
			if(3 to 6)
				progress_text = ", counting down the last few patches of trauma"
			if(6 to 9)
				progress_text = ", continuing to plug away at [target.p_their()] extensive damages"
			if(9 to 12)
				progress_text = ", steadying yourself for the long surgery ahead"
			if(12 to 15)
				progress_text = ", though [target.p_they()] still look[target.p_s()] heavily battered"
			if(15 to INFINITY)
				progress_text = ", though you feel like you're barely making a dent in treating [target.p_their()] broken body"

	return progress_text

/datum/surgery_step/robot_heal/get_feedback_message(mob/living/user, mob/living/target, speed_mod = 1)
	var/show_message = FALSE
	if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD) || HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		show_message = TRUE
	else if(locate(/obj/item/healthanalyzer) in user.held_items)
		show_message = TRUE
	else if(get_location_modifier(target) == OPERATING_COMPUTER_MODIFIER)
		show_message = TRUE

	if(!show_message)
		return

	if(heals_brute)
		return "[round(1 / speed_mod, 0.1)]x (<font color='#F0197D'>[target.get_brute_loss()]</font>) <font color='#7DF9FF'>[feedback_value]</font>"
	else
		return "[round(1 / speed_mod, 0.1)]x (<font color='#FF7F50'>[target.get_fire_loss()]</font>) <font color='#7DF9FF'>[feedback_value]</font>"

#undef DAMAGE_ROUNDING
#undef FAIL_DAMAGE_MULTIPLIER
#undef FINAL_STEP_HEAL_MULTIPLIER
