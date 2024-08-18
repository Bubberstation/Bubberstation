/datum/surgery/robot/amputation
	name = "Disassemble"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY | SURGERY_SELF_OPERABLE
	target_mobtypes = list(/mob/living/carbon/human/species/synth)
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/robot_sever_limb,
	)
	removes_target_bodypart = TRUE // SKYRAT EDIT ADDITION - Surgically unremovable limbs
	close_surgery = /datum/surgery/robot/close_amputation
	num_opening_steps = 3
	num_steps_until_closing = 6 // last step automatically closes

/datum/surgery/robot/close_amputation
	name = "Close Surgery (Disassemble)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY | SURGERY_SELF_OPERABLE
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/amputation/can_start(mob/user, mob/living/patient)
	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		return FALSE
	return ..()

/datum/surgery_step/robot_sever_limb
	name = "disconnect limb (wirecutters)"
	implements = list(
		TOOL_CROWBAR = 100,
		TOOL_HEMOSTAT = 75,
	)
	accept_hand = TRUE // You can just pull it off, like putting a limb on
	time = 2 SECONDS // It's not a slow procedure
	// TODO add sounds
	//preop_sound = 'sound/surgery/scalpel1.ogg'
	//success_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/robot_sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to disconnect [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] begins to disconnect [target]'s [parse_zone(target_zone)]!"),
		span_notice("[user] begins to disconnect [target]'s [parse_zone(target_zone)]!"),
	)
	//display_pain(target, "You feel a gruesome pain in your [parse_zone(target_zone)]'s joint!")

/datum/surgery_step/robot_sever_limb/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You sever [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] severs [target]'s [parse_zone(target_zone)]!"),
		span_notice("[user] severs [target]'s [parse_zone(target_zone)]!"),
	)
	display_pain(target, "You can no longer feel your severed [parse_zone(target_zone)]!")

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID) && ishuman(user))
		var/mob/living/carbon/human/morbid_weirdo = user
		morbid_weirdo.add_mood_event("morbid_dismemberment", /datum/mood_event/morbid_dismemberment)

	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()
	return ..()
