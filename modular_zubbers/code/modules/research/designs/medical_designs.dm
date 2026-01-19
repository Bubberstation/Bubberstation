/datum/design/empathic_sensor
	name = "Empathic sensor implant"
	desc = "An implant which allows one to intuit the thoughts of some."
	id = "ci_empathic_sensor"
	build_type = PROTOLATHE | MECHFAB
	materials = list(
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
	/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
	/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,)
	build_path = /obj/item/organ/cyberimp/brain/empathic_sensor
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/surgery/neurectomy
	name = "Neurectomy"
	desc = "An invasive surgical procedure which guarantees removal of deep-rooted brain traumas, but takes a while for the body to recover..."
	id = "surgery_neurectomy"
	surgery = /datum/surgery/advanced/neurectomy
	research_icon_state = "surgery_head"

/datum/design/surgery/neurectomy/blessed
	name = "Blessed Neurectomy"
	desc = "We're not quite sure exactly how it works, but with the blessing of a chaplain combined with modern chemicals, this manages to remove soul-bound traumas once thought to be magic."
	id = "surgery_blessed_neurectomy"
	surgery = /datum/surgery/advanced/neurectomy/blessed
	research_icon_state = "surgery_head"

/datum/techweb_node/surgery_adv/New()
	design_ids += "surgery_neurectomy"
	design_ids += "surgery_blessed_neurectomy"
	. = ..()

/datum/design/surgery/robot_trauma
	name = "Neural Defragmentation"
	desc = "A surgical procedure that refurbishes low level components in the posibrain, to fix deep-rooted trauma errors."
	id = "robotic_trauma_surgery"
	surgery = /datum/surgery/robot_trauma_surgery
	research_icon_state = "surgery_head"

/datum/design/surgery/robot_trauma/blessed
	name = "Devine Debugging"
	desc = "A surgical procedure that refurbishes low level components in the posibrain, to fix the strongest, soulbound trauma errors."
	id = "robotic_blessed_trauma_surgery"
	surgery = /datum/surgery/robot_trauma_surgery/blessed
	research_icon_state = "surgery_head"

//////////Medical Lathe Designs////////////

/datum/design/surgical_processor
	name = "Surgical Processor"
	id = "surgical_processor"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
	/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5,
	/datum/material/glass =SHEET_MATERIAL_AMOUNT*2,
	/datum/material/silver =SHEET_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/surgical_processor
	category = list(
	RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
