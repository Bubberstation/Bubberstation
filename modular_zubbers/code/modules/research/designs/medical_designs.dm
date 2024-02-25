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

******************************************************* TOXIN AND OXYGEN SURGERIES ******************************************************************
/datum/design/surgery/healing2 //PLEASE ACCOUNT FOR UNIQUE HEALING BRANCHES IN THE hptech HREF (currently 2 for Toxin/Oxygen; Combo is bonus)
	name = "Tend Blood"
	desc = "An upgraded version of the original surgery."
	id = "surgery_healing_base" //holder because CI cries otherwise. Not used in techweb unlocks.
	surgery = /datum/surgery/healing2
	research_icon_state = "surgery_chest"

/datum/design/surgery/healing2/toxin_upgrade
	name = "Tend Blood (Toxin) Upgrade"
	surgery = /datum/surgery/healing2/toxin/upgraded
	id = "surgery_heal_toxin_upgrade"

/datum/design/surgery/healing2/toxin_upgrade_2
	name = "Tend Blood (Toxin) Upgrade"
	surgery = /datum/surgery/healing2/toxin/upgraded/femto
	id = "surgery_heal_toxin_upgrade_femto"

/datum/design/surgery/healing2/oxygen_upgrade
	name = "Tend Blood (Oxygen) Upgrade"
	surgery = /datum/surgery/healing2/oxygen/upgraded
	id = "surgery_heal_oxygen_upgrade"

/datum/design/surgery/healing2/oxygen_upgrade_2
	name = "Tend Blood (Oxygen) Upgrade"
	surgery = /datum/surgery/healing2/oxygen/upgraded/femto
	id = "surgery_heal_oxygen_upgrade_femto"

/datum/design/surgery/healing2/combo
	name = "Tend Blood (Combo)"
	desc = "A surgical procedure that repairs both toxin and oxygen. Repair efficiency is not as high as the individual surgeries but it is faster."
	surgery = /datum/surgery/healing2/combo
	id = "surgery_heal_combo"

/datum/design/surgery/healing2/combo_upgrade
	name = "Tend Blood (Combo) Upgrade"
	surgery = /datum/surgery/healing2/combo/upgraded
	id = "surgery_heal_combo_upgrade"

/datum/design/surgery/healing2/combo_upgrade_2
	name = "Tend Blood (Combo) Upgrade"
	desc = "A surgical procedure that repairs both toxin and oxygen faster than their individual counterparts. It is more effective than both the individual surgeries."
	surgery = /datum/surgery/healing2/combo/upgraded/femto
	id = "surgery_heal_combo_upgrade_femto"
