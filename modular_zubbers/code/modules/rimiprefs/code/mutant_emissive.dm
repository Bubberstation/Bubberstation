/datum/preference/emissive_toggle
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	abstract_type = /datum/preference/emissive_toggle
	var/type_to_check = /datum/preference/toggle/allow_mismatched_parts
	var/check_mode = TRICOLOR_CHECK_BOOLEAN

/datum/preference/emissive_toggle/deserialize(input, datum/preferences/preferences)
	var/list/input_bools = input
	return list(sanitize_integer(input_bools[1]), sanitize_integer(input_bools[2]), sanitize_integer(input_bools[3]))

/datum/preference/emissive_toggle/create_default_value()
	return list(FALSE, FALSE, FALSE)

/datum/preference/emissive_toggle/is_valid(list/value)
	return islist(value) && value.len == 3 && isnum(value[1]) && isnum(value[2]) && isnum(value[3])

/datum/preference/emissive_toggle/is_accessible(datum/preferences/preferences)
	if(type == abstract_type)
		return ..(preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/part_enabled = preferences.read_preference(type_to_check)
	if(check_mode == TRICOLOR_CHECK_ACCESSORY)
		part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, part_enabled)
	return ((passed_initial_check || allowed) && part_enabled)

/datum/preference/emissive_toggle/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if (type == abstract_type)
		return ..()
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_EMISSIVE_LIST] = list(sanitize_integer(value[1]), sanitize_integer(value[2]), sanitize_integer(value[3]))
