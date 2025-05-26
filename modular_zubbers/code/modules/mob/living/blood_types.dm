///generic blood type for making new ones

/datum/blood_type/alt_color
	root_abstract_type = /datum/blood_type/alt_color

/datum/blood_type/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.name = real_blood_type.name
	. = ..()
	id = type_key()
	src.color = override_blood_type.color
	src.reagent_type = real_blood_type.reagent_type
	src.restoration_chem = real_blood_type.reagent_type
	src.compatible_types = LAZYCOPY(real_compatible_types)
	src.root_abstract_type = null

/datum/blood_type/alt_color/type_key()
	return "[name]_alt_[color]"

