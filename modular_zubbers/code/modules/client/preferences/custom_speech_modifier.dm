/datum/preference/text/custom_speech_modifier
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "custom_speech_modifier"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 64

/datum/preference/text/custom_speech_modifier/serialize(input)
	var/regex/unwanted_characters = regex(@"[^a-z]")
	if(unwanted_characters.Find(input))
		return null
	return htmlrendertext(input)

/datum/preference/text/custom_speech_modifier/ask
	savefile_key = "custom_speech_modifier_ask"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL

/datum/preference/text/custom_speech_modifier/exclaim
	savefile_key = "custom_speech_modifier_exclaim"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL

/datum/preference/text/custom_speech_modifier/whisper
	savefile_key = "custom_speech_modifier_whisper"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL

/datum/preference/text/custom_speech_modifier/yell
	savefile_key = "custom_speech_modifier_yell"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL

/datum/preference/text/custom_speech_modifier/say
	savefile_key = "custom_speech_modifier_say"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL

/datum/preference/text/custom_speech_modifier/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/text/custom_speech_modifier/ask/apply_to_human(mob/living/carbon/human/target, value)
	target.verb_ask = LOWER_TEXT(value)

/datum/preference/text/custom_speech_modifier/exclaim/apply_to_human(mob/living/carbon/human/target, value)
	target.verb_exclaim = LOWER_TEXT(value)

/datum/preference/text/custom_speech_modifier/whisper/apply_to_human(mob/living/carbon/human/target, value)
	target.verb_whisper = LOWER_TEXT(value)

/datum/preference/text/custom_speech_modifier/yell/apply_to_human(mob/living/carbon/human/target, value)
	target.verb_yell = LOWER_TEXT(value)

/datum/preference/text/custom_speech_modifier/say/apply_to_human(mob/living/carbon/human/target, value)
	target.verb_say = LOWER_TEXT(value)
