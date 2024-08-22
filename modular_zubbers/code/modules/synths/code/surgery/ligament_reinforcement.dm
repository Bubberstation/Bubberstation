/datum/surgery/robot/advanced/bioware/ligament_reinforcement
	name = "Anchor Point Reinforcement"
	desc = "A surgical procedure which adds reinforced limb anchor points to the patient's chassis, preventing dismemberment. \
		However, the nerve connections as a result are more easily interrupted, making it easier to disable limbs with damage."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/apply_bioware/reinforce_ligaments,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 7
	close_surgery = /datum/surgery/robot/advanced/bioware/close_ligament_reinforcement

	status_effect_gained = /datum/status_effect/bioware/ligaments/reinforced

/datum/surgery/robot/advanced/bioware/close_ligament_reinforcement
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
