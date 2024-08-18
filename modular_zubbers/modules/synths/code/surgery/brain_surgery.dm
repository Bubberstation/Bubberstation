/datum/surgery/robot/brain_surgery
	name = "Reset Posibrain Logic (Brain Surgery)"
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_robot_brain,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)

	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/close_brain_surgery
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST) // The brains are in the chest
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A surgical procedure that restores the default behavior logic and personality matrix of an IPC posibrain."
	surgery_flags = SURGERY_SELF_OPERABLE

/datum/surgery/robot/close_brain_surgery
	name = "Close Surgery (Reset Posibrain Logic (Brain Surgery))"
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST) // The brains are in the chest
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_SELF_OPERABLE

/datum/surgery/robot/brain_surgery/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	..()
	var/obj/item/organ/internal/brain/synth/brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain) && !issynthetic(target))
		return FALSE
	else
		return TRUE
