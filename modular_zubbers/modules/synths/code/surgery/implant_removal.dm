/datum/surgery_step/extract_implant/robot
	name = "extract implant (crowbar)"
	implements = list(
		TOOL_CROWBAR = 100,
		TOOL_HEMOSTAT = 75,
		/obj/item/kitchen/fork = 55)
	// TODO add sound

/datum/surgery/robot/implant_removal
	name = "Uninstall Implant"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	target_mobtypes = list(/mob/living/carbon/human) // Simpler mobs don't have bodypart types
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/extract_implant/robot,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,)
	num_opening_steps = 2
	num_steps_until_closing = 5
	close_surgery = /datum/surgery/robot/close_implant_removal
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_SELF_OPERABLE

/datum/surgery/robot/close_implant_removal
	name = "Close Surgery (Uninstall Implant)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	target_mobtypes = list(/mob/living/carbon/human) // Simpler mobs don't have bodypart types
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,)
	is_closer = TRUE
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_SELF_OPERABLE
