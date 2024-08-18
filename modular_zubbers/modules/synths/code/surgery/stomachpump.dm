/datum/surgery/robot/stomach_pump
	name = "Nutrient Processing Purge"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/stomach_pump,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	surgery_flags = SURGERY_SELF_OPERABLE
	num_opening_steps = 2
	num_steps_until_closing = 4
	close_surgery = /datum/surgery/robot/close_stomach_pump

/datum/surgery/robot/close_stomach_pump
	name = "Close Surgery (Nutrient Processing Purge)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/stomach_pump/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/stomach/target_stomach = target.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(HAS_TRAIT(target, TRAIT_HUSK))
		return FALSE
	if(!target_stomach)
		return FALSE
	return ..()

/datum/surgery_step/stomach_pump/mechanic
	name = "pump bioprocessor (hand)"
	accept_hand = TRUE
	repeatable = TRUE
	time = 20
	success_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/stomach_pump/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin pumping [target]'s stomach..."),
		span_notice("[user] begins to pump [target]'s stomach."),
		span_notice("[user] begins to press on [target]'s chest."),
	)
	display_pain(target, "You feel a horrible sloshing feeling in your gut! You're going to be sick!")

/datum/surgery_step/stomach_pump/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/target_human = target
		display_results(
			user,
			target,
			span_notice("[user] forces [target_human] to vomit, cleansing their stomach of some chemicals!"),
			span_notice("[user] forces [target_human] to vomit, cleansing their stomach of some chemicals!"),
			span_notice("[user] forces [target_human] to vomit!"),
		)
		target_human.vomit((MOB_VOMIT_MESSAGE | MOB_VOMIT_STUN), lost_nutrition = 20, purge_ratio = 0.67) //higher purge ratio than regular vomiting
	return ..()

/datum/surgery_step/stomach_pump/mechanic/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/target_human = target
		display_results(
			user,
			target,
			span_warning("You screw up, bruising [target_human]'s chest!"),
			span_warning("[user] screws up, brusing [target_human]'s chest!"),
			span_warning("[user] screws up!"),
		)
		target_human.adjustOrganLoss(ORGAN_SLOT_STOMACH, 5)
		target_human.adjustBruteLoss(5)
