//why couldnt it just be a unified system...

/datum/blood_type/custom
	root_abstract_type = /datum/blood_type/custom

/datum/blood_type/custom/New(datum/blood_type/real_blood_type, list/real_compatible_types)
	src.name = real_blood_type.name
	. = ..()
	src.color = real_blood_type.color
	src.reagent_type = real_blood_type.reagent_type
	src.restoration_chem = real_blood_type.reagent_type
	src.compatible_types = LAZYCOPY(real_compatible_types)
	src.root_abstract_type = null

/datum/blood_type/custom/type_key()
	return "[name]_custom"

