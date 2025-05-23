/datum/surgery/eye_surgery
	requires_bodypart_type = BODYTYPE_ORGANIC | BODYTYPE_ALIEN | BODYTYPE_NANO | BODYTYPE_SHADOW

/datum/surgery/eye_surgery/mechanic
	name = "Optical Sensor repair"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_eyes/mechanic,
		/datum/surgery_step/mechanic_close
	)

/datum/surgery_step/fix_eyes/mechanic
	name = "repair optical sensor (screwdriver/hemostat)"
	implements = list(
		TOOL_SCREWDRIVER = 100,
		TOOL_HEMOSTAT = 45,
		/obj/item/pen = 25)
