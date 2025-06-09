// For Skrell
/datum/blood_type/copper
	name = BLOOD_TYPE_COPPER
	dna_string = "Skrell DNA"
	reagent_type = /datum/reagent/copper
	color = BLOOD_COLOR_COPPER
	restoration_chem = null

// For Proteans
/datum/blood_type/nanite_slurry
	name = BLOOD_TYPE_NANITE_SLURRY
	dna_string = "Nanite Slurry"
	reagent_type = /datum/reagent/medicine/nanite_slurry
	color = BLOOD_COLOR_NANITE_SLURRY
	restoration_chem = null

/* blood type template
/datum/blood_type/namehere/alt_color
	root_abstract_type = /datum/blood_type/namehere


/datum/blood_type/namehere/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	. = ..()
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/alt_color/type_key()
	return "[name]_alt_[color]"

*/

/datum/blood_type/human/a_minus/alt_color
	root_abstract_type = /datum/blood_type/human

/datum/blood_type/human/a_minus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/a_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/a_plus/alt_color
	root_abstract_type = /datum/blood_type/human

/datum/blood_type/human/a_plus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/a_plus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/b_minus/alt_color
	root_abstract_type = /datum/blood_type/human
/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/b_minus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/b_plus/alt_color
	root_abstract_type = /datum/blood_type/human

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/b_plus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/ab_minus/alt_color
	root_abstract_type = /datum/blood_type/human

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/ab_minus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/ab_plus/alt_color
	root_abstract_type = /datum/blood_type/human

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/ab_plus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/o_minus/alt_color
	root_abstract_type = /datum/blood_type/human

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/o_minus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/o_plus/alt_color
	root_abstract_type = /datum/blood_type/human

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/human/o_plus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/animal/alt_color
	root_abstract_type = /datum/blood_type/animal

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/animal/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/lizard/alt_color
	root_abstract_type = /datum/blood_type/lizard

/datum/blood_type/lizard/alt_color/New(datum/blood_type/override_blood_type)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/lizard/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/oil/alt_color
	root_abstract_type = /datum/blood_type/oil

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/oil/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/vampire/alt_color
	root_abstract_type = /datum/blood_type/vampire

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/vampire/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/universal/alt_color
	root_abstract_type = /datum/blood_type/universal

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/universal/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/meat/alt_color
	root_abstract_type = /datum/blood_type/meat

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/meat/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/slime/alt_color
	root_abstract_type = /datum/blood_type/slime

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/slime/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/water/alt_color
	root_abstract_type = /datum/blood_type/water

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/water/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/snail/alt_color
	root_abstract_type = /datum/blood_type/snail

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/real_blood_type, datum/blood_type/override_blood_type, list/real_compatible_types)
	src.id = type_key()
	src.color = override_blood_type.color

/datum/blood_type/snail/alt_color/type_key()
	return "[name]_alt_[color]"
