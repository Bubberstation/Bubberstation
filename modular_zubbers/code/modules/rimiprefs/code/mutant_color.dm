/datum/preference/mutant_color
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	abstract_type = /datum/preference/mutant_color
	var/type_to_check = /datum/preference/toggle/allow_mismatched_parts
	var/check_mode = TRICOLOR_CHECK_BOOLEAN

/datum/preference/mutant_color/deserialize(input, datum/preferences/preferences)
	var/list/input_colors = input
	return list(sanitize_hexcolor(input_colors[1]), sanitize_hexcolor(input_colors[2]), sanitize_hexcolor(input_colors[3]))

/datum/preference/mutant_color/create_default_value()
	return list("#[random_color()]", "#[random_color()]", "#[random_color()]")

/datum/preference/mutant_color/is_valid(list/value)
	return islist(value) && value.len == 3 && (findtext(value[1], GLOB.is_color) && findtext(value[2], GLOB.is_color) && findtext(value[3], GLOB.is_color))

/datum/preference/mutant_color/is_accessible(datum/preferences/preferences)
	if (check_mode == TRICOLOR_NO_CHECK || type == abstract_type)
		return ..(preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/part_enabled = preferences.read_preference(type_to_check)
	if(check_mode == TRICOLOR_CHECK_ACCESSORY)
		part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, part_enabled)
	return ((passed_initial_check || allowed) && part_enabled)

/datum/preference/mutant_color/apply_to_human(mob/living/carbon/human/target, value)
	if (type == abstract_type)
		return ..()
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_COLOR_LIST] = list(sanitize_hexcolor(value[1]), sanitize_hexcolor(value[2]), sanitize_hexcolor(value[3]))
