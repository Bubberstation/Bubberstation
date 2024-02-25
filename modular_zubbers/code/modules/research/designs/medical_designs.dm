/datum/design/crewmonitor
	name = "Handheld crew monitor"
	desc = "A miniature machine that tracks suit sensors across the station."
	id = "crewmonitor"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/sensor_device
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

//******************************************************* TOXIN AND OXYGEN SURGERIES ******************************************************************
/datum/design/surgery/healing2
	desc = "An upgraded version of the original surgery."
	id = "surgery_healing2_base"
	surgery = /datum/surgery/healing2
	research_icon_state = "surgery_chest"

/datum/design/surgery/healing2/toxin_upgrade
	name = "Tend Blood (Toxin) Upgrade"
	surgery = /datum/surgery/healing2/toxin/upgraded
	id = "surgery_heal2_toxin_upgrade"

/datum/design/surgery/healing2/toxin_upgrade_2
	name = "Tend Blood (Toxin) Upgrade"
	surgery = /datum/surgery/healing2/toxin/upgraded/femto
	id = "surgery_heal2_toxin_upgrade_femto"
