/datum/blood_type
	///blood type to be edited for change_blood_color
	var/recolor_blood_type //datum typepath for the alt_color version of the blood type

/datum/blood_type/proc/make_alt_color(override, datum/blood_type/orig)
	var/datum/blood_type/original = orig
	name = "[name] ([override])"
	color = override
	id = name
	testing("created alternate [id]")
	compatible_types = LAZYLISTDUPLICATE(original?.compatible_types)

// For Skrell
/datum/blood_type/copper
	name = BLOOD_TYPE_COPPER
	dna_string = "Skrell DNA"
	reagent_type = /datum/reagent/copper
	color = BLOOD_COLOR_COPPER
	restoration_chem = null
	recolor_blood_type = /datum/blood_type/copper/alt_color

/datum/blood_type/copper/alt_color
	abstract_type = /datum/blood_type/copper

/datum/blood_type/copper/alt_color/type_key()
	return /datum/blood_type/copper

/datum/blood_type/copper/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

// For Proteans
/datum/blood_type/nanite_slurry
	name = BLOOD_TYPE_NANITE_SLURRY
	dna_string = "Nanite Slurry"
	reagent_type = /datum/reagent/medicine/nanite_slurry
	color = BLOOD_COLOR_NANITE_SLURRY
	restoration_chem = null
	recolor_blood_type = /datum/blood_type/nanite_slurry/alt_color

/datum/blood_type/nanite_slurry/alt_color
	abstract_type = /datum/blood_type/nanite_slurry

/datum/blood_type/nanite_slurry/alt_color/type_key()
	return /datum/blood_type/nanite_slurry

/datum/blood_type/nanite_slurry/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/* blood type template for alt_colors
/datum/blood_type/namehere
	recolor_blood_type = /datum/blood_type/namehere/alt_color

/datum/blood_type/namehere/alt_color
	abstract_type = /datum/blood_type/namehere/alt_color

/datum/blood_type/namehere/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/alt_color/type_key()
	return /datum/blood_type/PARENT_TYPE_HERE
*/

///A-
/datum/blood_type/human/a_minus
	recolor_blood_type = /datum/blood_type/human/a_minus/alt_color

/datum/blood_type/human/a_minus/alt_color
	/* abstract_type = /datum/blood_type/human/a_minus/alt_color */

/datum/blood_type/human/a_minus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/a_minus/alt_color/type_key()
	return /datum/blood_type/human/a_minus

///A+
/datum/blood_type/human/a_plus
	recolor_blood_type = /datum/blood_type/human/a_plus/alt_color

/datum/blood_type/human/a_plus/alt_color
	/* abstract_type = /datum/blood_type/human/a_plus/alt_color */

/datum/blood_type/human/a_plus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/a_plus/alt_color/type_key()
	return /datum/blood_type/human/a_plus

///B+
/datum/blood_type/human/b_plus
	recolor_blood_type = /datum/blood_type/human/b_plus/alt_color

/datum/blood_type/human/b_plus/alt_color
	/* abstract_type = /datum/blood_type/human/b_plus/alt_color */

/datum/blood_type/human/b_plus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/b_plus/alt_color/type_key()
	return /datum/blood_type/human/b_plus

///B-
/datum/blood_type/human/b_minus
	recolor_blood_type = /datum/blood_type/human/b_minus/alt_color

/datum/blood_type/human/b_minus/alt_color
	/* abstract_type = /datum/blood_type/human/b_minus/alt_color */

/datum/blood_type/human/b_minus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/b_minus/alt_color/type_key()
	return /datum/blood_type/human/b_minus

///AB-
/datum/blood_type/human/ab_minus
	recolor_blood_type = /datum/blood_type/human/ab_minus/alt_color

/datum/blood_type/human/ab_minus/alt_color
	/* abstract_type = /datum/blood_type/human/ab_minus/alt_color */

/datum/blood_type/human/ab_minus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/ab_minus/alt_color/type_key()
	return /datum/blood_type/human/ab_minus

///AB+
/datum/blood_type/human/ab_plus
	recolor_blood_type = /datum/blood_type/human/ab_plus/alt_color

/datum/blood_type/human/ab_plus/alt_color
	/* abstract_type = /datum/blood_type/human/ab_plus/alt_color */

/datum/blood_type/human/ab_plus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/ab_plus/alt_color/type_key()
	return /datum/blood_type/human/ab_plus

///O-
/datum/blood_type/human/o_minus
	recolor_blood_type = /datum/blood_type/human/o_minus/alt_color

/datum/blood_type/human/o_minus/alt_color
	/* abstract_type = /datum/blood_type/human/o_minus/alt_color */

/datum/blood_type/human/o_minus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/o_minus/alt_color/type_key()
	return /datum/blood_type/human/o_minus

///O+
/datum/blood_type/human/o_plus
	recolor_blood_type = /datum/blood_type/human/o_plus/alt_color

/datum/blood_type/human/o_plus/alt_color
	/* abstract_type = /datum/blood_type/human/o_plus/alt_color */

/datum/blood_type/human/o_plus/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/human/o_plus/alt_color/type_key()
	return /datum/blood_type/human/o_plus

///Y-
/datum/blood_type/animal
	recolor_blood_type = /datum/blood_type/animal/alt_color

/datum/blood_type/animal/alt_color
	abstract_type = /datum/blood_type/animal/alt_color

/datum/blood_type/animal/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/animal/alt_color/type_key()
	return /datum/blood_type/animal

///L
/datum/blood_type/lizard
	recolor_blood_type = /datum/blood_type/lizard/alt_color

/datum/blood_type/lizard/alt_color
	abstract_type = /datum/blood_type/lizard/alt_color

/datum/blood_type/lizard/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/lizard/alt_color/type_key()
	return /datum/blood_type/lizard

///LE
/datum/blood_type/ethereal
	recolor_blood_type = /datum/blood_type/ethereal/alt_color

/datum/blood_type/ethereal/alt_color
	abstract_type = /datum/blood_type/ethereal/alt_color

/datum/blood_type/ethereal/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/ethereal/alt_color/type_key()
	return /datum/blood_type/ethereal

///Oil
/datum/blood_type/oil
	recolor_blood_type = /datum/blood_type/oil/alt_color

/datum/blood_type/oil/alt_color
	abstract_type = /datum/blood_type/oil/alt_color

/datum/blood_type/oil/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/oil/alt_color/type_key()
	return /datum/blood_type/oil

///V
/datum/blood_type/vampire
	recolor_blood_type = /datum/blood_type/vampire/alt_color

/datum/blood_type/vampire/alt_color
	abstract_type = /datum/blood_type/vampire/alt_color

/datum/blood_type/vampire/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/vampire/alt_color/type_key()
	return /datum/blood_type/vampire

///U
/datum/blood_type/universal
	recolor_blood_type = /datum/blood_type/universal/alt_color

/datum/blood_type/universal/alt_color
	abstract_type = /datum/blood_type/universal/alt_color

/datum/blood_type/universal/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/universal/alt_color/type_key()
	return /datum/blood_type/universal

///MT-
/datum/blood_type/meat
	recolor_blood_type = /datum/blood_type/meat/alt_color

/datum/blood_type/meat/alt_color
	abstract_type = /datum/blood_type/meat/alt_color

/datum/blood_type/meat/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/meat/alt_color/type_key()
	return /datum/blood_type/meat

///TOX
/datum/blood_type/slime
	recolor_blood_type = /datum/blood_type/slime/alt_color

/datum/blood_type/slime/alt_color
	abstract_type = /datum/blood_type/slime/alt_color

/datum/blood_type/slime/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/slime/alt_color/type_key()
	return /datum/blood_type/slime

///H2O
/datum/blood_type/water
	recolor_blood_type = /datum/blood_type/water/alt_color

/datum/blood_type/water/alt_color
	abstract_type = /datum/blood_type/water/alt_color

/datum/blood_type/water/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/water/alt_color/type_key()
	return /datum/blood_type/water

///S
/datum/blood_type/snail
	recolor_blood_type = /datum/blood_type/snail/alt_color

/datum/blood_type/snail/alt_color
	abstract_type = /datum/blood_type/snail/alt_color

/datum/blood_type/snail/alt_color/New(override, datum/blood_type/orig)
	make_alt_color(override, orig)

/datum/blood_type/snail/alt_color/type_key()
	return /datum/blood_type/snail
