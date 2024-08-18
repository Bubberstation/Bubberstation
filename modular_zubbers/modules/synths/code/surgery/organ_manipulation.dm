/datum/surgery/robot/organ_manipulation
	name = "Hardware Manipulation"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_SELF_OPERABLE | SURGERY_REQUIRE_LIMB
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs/internal/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 5
	close_surgery = /datum/surgery/robot/close_organ_manipulation

/datum/surgery/robot/close_organ_manipulation/
	name = "Close Surgery (Hardware Manipulation)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_SELF_OPERABLE | SURGERY_REQUIRE_LIMB
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/organ_manipulation/soft
	possible_locs = list(
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_PRECISE_EYES,
		BODY_ZONE_PRECISE_MOUTH,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs/internal/mechanic,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 2
	num_steps_until_closing = 4
	close_surgery = /datum/surgery/robot/organ_manipulation/soft/close

/datum/surgery/robot/organ_manipulation/soft/close
	name = "Close Surgery (Hardware Manipulation)"
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/organ_manipulation/external
	name = "Chassis Manipulation"
	possible_locs = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/manipulate_organs/external/mechanic,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 2
	num_steps_until_closing = 3
	close_surgery = /datum/surgery/robot/organ_manipulation/external/close

/datum/surgery/robot/organ_manipulation/external/close
	name = "Close Surgery (Chassis Manipulation)"
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery_step/manipulate_organs/internal/mechanic
	implements_extract = list(TOOL_HEMOSTAT = 100, TOOL_WIRECUTTER = 100, /obj/item/kitchen/fork = 35)
	name = "manipulate prosthetic organs (hemostat or wirecutter/organ)"

/datum/surgery_step/manipulate_organs/external/mechanic
	implements_extract = list(TOOL_HEMOSTAT = 100, TOOL_WIRECUTTER = 100, /obj/item/kitchen/fork = 35)
	name = "manipulate prosthetic features (hemostat or wirecutter/feature)"
