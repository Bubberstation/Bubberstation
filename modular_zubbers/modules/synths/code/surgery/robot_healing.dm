// Override of skyrat code

#define DAMAGE_ROUNDING 0.1
#define FAIL_DAMAGE_MULTIPLIER 0.8
#define FINAL_STEP_HEAL_MULTIPLIER 0.55

//Almost copypaste of tend wounds, with some changes
/datum/surgery/robot_healing
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/robot_heal,
		/datum/surgery_step/mechanic_close,
	)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	replaced_by = /datum/surgery
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_IGNORE_CLOTHES | SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB

	/// The step to use in the 4th surgery step.
	healing_step_type
	/// If true, doesn't send the surgery preop message. Set during surgery.
	surgery_preop_message_sent = FALSE

/datum/surgery/robot_healing/New(surgery_target, surgery_location, surgery_bodypart)
	..()
	if(healing_step_type)
		steps = list(
			/datum/surgery_step/mechanic_open,
			healing_step_type,
			/datum/surgery_step/mechanic_close,
		)

/datum/surgery_step/robot_heal
	name = "repair body (crowbar/wirecutters)"
	implements = list(TOOL_CROWBAR = 100, TOOL_WIRECUTTER = 100)
	repeatable = TRUE
	time = 2.5 SECONDS

	/// If this surgery is healing brute damage. Set during operation steps.
	heals_brute = FALSE
	/// If this surgery is healing burn damage. Set during operation steps.
	heals_burn = FALSE
	/// How much healing the sugery gives.
	brute_heal_amount = 0
	/// How much healing the sugery gives.
	burn_heal_amount = 0
	/// Heals an extra point of damage per X missing damage of type (burn damage for burn healing, brute for brute). Smaller number = more healing!
	missing_health_bonus = 0

/datum/surgery_step/robot_heal/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/woundtype
	if(!istype(surgery, /datum/surgery/robot_healing))
		return

	var/datum/surgery/robot_healing/the_surgery = surgery

	if(implement_type == TOOL_CROWBAR)
		if(!heals_brute)
			the_surgery.surgery_preop_message_sent = FALSE
		heals_brute = TRUE
		heals_burn = FALSE
		woundtype = "dents"
	else
		if(!heals_burn)
			the_surgery.surgery_preop_message_sent = FALSE
		heals_brute = FALSE
		heals_burn = TRUE
		woundtype = "wiring"

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
		while((heals_brute && target.getBruteLoss()) || (heals_burn && target.getFireLoss()))
			if(!..())
				break

/datum/surgery_step/robot_heal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/self_message = "You succeed in fixing some of [target]'s damage" //no period, add initial space to "addons"
	var/other_message = "[user] fixes some of [target]'s damage" //see above
	var/healed_brute = 0
	var/healed_burn = 0
	healed_brute = brute_heal_amount
	healed_burn = burn_heal_amount

	if(missing_health_bonus)
		if(target.stat != DEAD)
			healed_brute += round((target.getBruteLoss() / missing_health_bonus), DAMAGE_ROUNDING)
			healed_burn += round((target.getFireLoss() / missing_health_bonus), DAMAGE_ROUNDING)

		else //less healing bonus for the dead since they're expected to have lots of damage to begin with (to make TW into defib not TOO simple)
			healed_brute += round((target.getBruteLoss() / (missing_health_bonus * 5)), DAMAGE_ROUNDING)
			healed_burn += round((target.getFireLoss() / (missing_health_bonus * 5)), DAMAGE_ROUNDING)

	if(!get_location_accessible(target, target_zone))
		healed_brute *= FINAL_STEP_HEAL_MULTIPLIER
		healed_burn *= FINAL_STEP_HEAL_MULTIPLIER
		self_message += " as best as you can while they have clothing on"
		other_message += " as best as they can while [target] has clothing on"

	// don't heal a damage type if the surgery doesn't heal it
	// true is 1, false is 0
	healed_brute *= heals_brute
	healed_burn *= heals_burn

	target.heal_bodypart_damage(healed_brute, healed_burn, 0, BODYTYPE_ROBOTIC)

	self_message += get_progress(user, target, healed_brute, healed_burn)

	display_results(user, target, span_notice("[self_message]."), "[other_message].", "[other_message].")

	if(istype(surgery, /datum/surgery/robot_healing))
		var/datum/surgery/robot_healing/the_surgery = surgery
		the_surgery.surgery_preop_message_sent = TRUE

	return TRUE
