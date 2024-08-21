/datum/design/hospital_gown
	name = "Hospital Gown"
	id = "hospital_gown"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/suit/toggle/labcoat/hospitalgown
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/surgery/healing/robotic_healing_upgrade
	name = "Repair robotics upgrade: Advanced" // BUBBER EDIT
	surgery = /datum/surgery/robot/healing/upgraded // BUBBER EDIT
	id = "robotic_heal_surgery_upgrade"

/datum/design/surgery/healing/robotic_healing_upgrade_2
	name = "Repair robotics upgrade: Experimental" // BUBBER EDIT
	surgery = /datum/surgery/robot/healing/experimental // BUBBER EDIT
	id = "robotic_heal_surgery_upgrade_2"

//Limb Grower
/datum/design/nitrogen_lungs
	name = "Standard Nitrogen Lungs"
	id = "nitrogenlunggeneric"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 20)
	build_path = /obj/item/organ/internal/lungs/nitrogen
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)

/datum/design/vox_nitrogen_lungs
	name = "Vox Nitrogen Lungs"
	id = "nitrogenlungvox"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 20)
	build_path = /obj/item/organ/internal/lungs/nitrogen/vox
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)


