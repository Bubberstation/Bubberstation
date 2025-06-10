// For Skrell
/datum/blood_type/copper
	name = BLOOD_TYPE_COPPER
	dna_string = "Skrell DNA"
	reagent_type = /datum/reagent/copper
	color = BLOOD_COLOR_COPPER
	restoration_chem = null
	recolor_blood_type = /datum/blood_type/copper/alt_color

/datum/blood_type/copper/alt_color
	root_abstract_type = /datum/blood_type/copper/alt_color

/datum/blood_type/copper/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/copper/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

// For Proteans
/datum/blood_type/nanite_slurry
	name = BLOOD_TYPE_NANITE_SLURRY
	dna_string = "Nanite Slurry"
	reagent_type = /datum/reagent/medicine/nanite_slurry
	color = BLOOD_COLOR_NANITE_SLURRY
	restoration_chem = null
	recolor_blood_type = /datum/blood_type/nanite_slurry/alt_color

/datum/blood_type/nanite_slurry/alt_color
	root_abstract_type = /datum/blood_type/nanite_slurry/alt_color

/datum/blood_type/nanite_slurry/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/nanite_slurry/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type
	///blood type to be edited for change_blood_color
	var/recolor_blood_type

/* blood type template for alt_colors
/datum/blood_type/namehere
	recolor_blood_type = /datum/blood_type/namehere/alt_color

/datum/blood_type/namehere/alt_color
	root_abstract_type = /datum/blood_type/namehere/alt_color

/datum/blood_type/namehere/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color

/datum/blood_type/alt_color/type_key()
	return "[name]_alt_[color]"
*/

///A-
/datum/blood_type/human/a_minus
	recolor_blood_type = /datum/blood_type/human/a_minus/alt_color

/datum/blood_type/human/a_minus/alt_color
	root_abstract_type = /datum/blood_type/human/a_minus/alt_color

/datum/blood_type/human/a_minus/alt_color/type_key()
	return "[name]_alt_[color]"

/datum/blood_type/human/a_minus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

///A+
/datum/blood_type/human/a_plus
	recolor_blood_type = /datum/blood_type/human/a_plus/alt_color

/datum/blood_type/human/a_plus/alt_color
	root_abstract_type = /datum/blood_type/human/a_plus/alt_color

/datum/blood_type/human/a_plus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/human/a_plus/alt_color/type_key()
	return "[name]_alt_[color]"

///B+
/datum/blood_type/human/b_plus
	recolor_blood_type = /datum/blood_type/human/b_plus/alt_color

/datum/blood_type/human/b_plus/alt_color
	root_abstract_type = /datum/blood_type/human/b_plus/alt_color

/datum/blood_type/human/b_plus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/human/b_plus/alt_color/type_key()
	return "[name]_alt_[color]"

///B-
/datum/blood_type/human/b_minus
	recolor_blood_type = /datum/blood_type/human/b_minus/alt_color

/datum/blood_type/human/b_minus/alt_color
	root_abstract_type = /datum/blood_type/human/b_minus/alt_color

/datum/blood_type/human/b_minus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/human/b_minus/alt_color/type_key()
	return "[name]_alt_[color]"

///AB-
/datum/blood_type/human/ab_minus
	recolor_blood_type = /datum/blood_type/human/ab_minus/alt_color

/datum/blood_type/human/ab_minus/alt_color
	root_abstract_type = /datum/blood_type/human/ab_minus/alt_color

/datum/blood_type/human/ab_minus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/human/ab_minus/alt_color/type_key()
	return "[name]_alt_[color]"

///AB+
/datum/blood_type/human/ab_plus
	recolor_blood_type = /datum/blood_type/human/ab_plus/alt_color

/datum/blood_type/human/ab_plus/alt_color
	root_abstract_type = /datum/blood_type/human/ab_plus/alt_color

/datum/blood_type/human/ab_plus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/human/ab_plus/alt_color/type_key()
	return "[name]_alt_[color]"

///O-
/datum/blood_type/human/o_minus
	recolor_blood_type = /datum/blood_type/human/o_minus/alt_color

/datum/blood_type/human/o_minus/alt_color
	root_abstract_type = /datum/blood_type/human/o_minus/alt_color

/datum/blood_type/human/o_minus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/human/o_minus/alt_color/type_key()
	return "[name]_alt_[color]"

///O+
/datum/blood_type/human/o_plus
	recolor_blood_type = /datum/blood_type/human/o_plus/alt_color

/datum/blood_type/human/o_plus/alt_color
	root_abstract_type = /datum/blood_type/human/o_plus/alt_color

/datum/blood_type/human/o_plus/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/human/o_plus/alt_color/type_key()
	return "[name]_alt_[color]"

///Y-
/datum/blood_type/animal
	recolor_blood_type = /datum/blood_type/animal/alt_color

/datum/blood_type/animal/alt_color
	root_abstract_type = /datum/blood_type/animal/alt_color

/datum/blood_type/animal/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/animal/alt_color/type_key()
	return "[name]_alt_[color]"

///L
/datum/blood_type/lizard
	recolor_blood_type = /datum/blood_type/lizard/alt_color

/datum/blood_type/lizard/alt_color
	root_abstract_type = /datum/blood_type/lizard/alt_color

/datum/blood_type/lizard/alt_color/New(datum/blood_type/override)
	id = type_key()
	if(!isnull(override.color))
		color = override.color
	root_abstract_type = null

/datum/blood_type/lizard/alt_color/type_key()
	return "[name]_alt_[color]"

///LE
/datum/blood_type/ethereal
	recolor_blood_type = /datum/blood_type/ethereal/alt_color

/datum/blood_type/ethereal/alt_color
	root_abstract_type = /datum/blood_type/ethereal/alt_color

/datum/blood_type/ethereal/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/ethereal/alt_color/type_key()
	return "[name]_alt_[color]"

///Oil
/datum/blood_type/oil
	recolor_blood_type = /datum/blood_type/oil/alt_color

/datum/blood_type/oil/alt_color
	root_abstract_type = /datum/blood_type/oil/alt_color

/datum/blood_type/oil/alt_color/New(datum/blood_type/override)
	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/oil/alt_color/type_key()
	return "[name]_alt_[color]"

///V
/datum/blood_type/vampire
	recolor_blood_type = /datum/blood_type/vampire/alt_color

/datum/blood_type/vampire/alt_color
	root_abstract_type = /datum/blood_type/vampire/alt_color

/datum/blood_type/vampire/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/vampire/alt_color/type_key()
	return "[name]_alt_[color]"

///U
/datum/blood_type/universal
	recolor_blood_type = /datum/blood_type/universal/alt_color

/datum/blood_type/universal/alt_color
	root_abstract_type = /datum/blood_type/universal/alt_color

/datum/blood_type/universal/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/universal/alt_color/type_key()
	return "[name]_alt_[color]"

///MT-
/datum/blood_type/meat
	recolor_blood_type = /datum/blood_type/meat/alt_color

/datum/blood_type/meat/alt_color
	root_abstract_type = /datum/blood_type/meat/alt_color

/datum/blood_type/meat/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/meat/alt_color/type_key()
	return "[name]_alt_[color]"

///TOX
/datum/blood_type/slime
	recolor_blood_type = /datum/blood_type/slime/alt_color

/datum/blood_type/slime/alt_color
	root_abstract_type = /datum/blood_type/slime/alt_color

/datum/blood_type/slime/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/slime/alt_color/type_key()
	return "[name]_alt_[color]"

///H2O
/datum/blood_type/water
	recolor_blood_type = /datum/blood_type/water/alt_color

/datum/blood_type/water/alt_color
	root_abstract_type = /datum/blood_type/water/alt_color

/datum/blood_type/water/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/water/alt_color/type_key()
	return "[name]_alt_[color]"

///S
/datum/blood_type/snail
	recolor_blood_type = /datum/blood_type/snail/alt_color

/datum/blood_type/snail/alt_color
	root_abstract_type = /datum/blood_type/snail/alt_color

/datum/blood_type/snail/alt_color/New(datum/blood_type/override)

	id = type_key()
	color = override.color
	root_abstract_type = null

/datum/blood_type/snail/alt_color/type_key()
	return "[name]_alt_[color]"
