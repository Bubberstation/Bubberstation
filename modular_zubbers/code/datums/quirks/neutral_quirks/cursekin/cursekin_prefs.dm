GLOBAL_LIST_INIT(possible_lycan_tf_sounds, list(
	"modular_zubbers/code/modules/customization/species/lycans/transform.ogg" = "Howl",
	"modular_skyrat/modules/horrorform/sound/tear.ogg" = "Flesh Tearing",
	"sound/effects/magic/mutate.ogg" = "Flesh Tearing (Magical)",
	"sound/effects/magic/staff_change.ogg" = "Magical",
))

/datum/preference/numeric/cursekin_char_slot
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "cursekin_char_slot"
	can_randomize = FALSE
	minimum = 1
	maximum = /datum/preferences::max_save_slots

/datum/preference/numeric/cursekin_char_slot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/cursekin_char_slot/create_default_value()
	return 1

/datum/preference/text/cursekin_transform_text
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "cursekin_transform_text"
	can_randomize = FALSE
	maximum_value_length = 128

/datum/preference/text/cursekin_transform_text/create_default_value()
	return "%OWNER turns %PRONOUN head to the sky and howls, growing into a terrible beast"

/datum/preference/text/cursekin_transform_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/text/cursekin_detransform_text
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "cursekin_detransform_text"
	can_randomize = FALSE
	maximum_value_length = 128

/datum/preference/text/cursekin_detransform_text/create_default_value()
	return "%OWNER shrinks down, %PRONOUN fur receding"

/datum/preference/text/cursekin_detransform_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/choiced/cursekin_sfx
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "cursekin_sfx"
	can_randomize = FALSE

/datum/preference/choiced/cursekin_sfx/compile_constant_data()
	var/list/data = ..()

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.possible_lycan_tf_sounds

	return data

/datum/preference/choiced/cursekin_sfx
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "cursekin_sfx"
	can_randomize = FALSE

/datum/preference/choiced/cursekin_sfx/compile_constant_data()
	var/list/data = ..()

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.possible_lycan_tf_sounds

	return data

/datum/preference/choiced/cursekin_sfx/create_default_value()
	return "modular_zubbers/code/modules/customization/species/lycans/transform.ogg"

/datum/preference/choiced/cursekin_sfx/init_possible_values()
	var/list/values = list()

	for (var/entry as anything in GLOB.possible_lycan_tf_sounds)
		values += entry

	return values

/datum/preference/choiced/cursekin_sfx/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return
