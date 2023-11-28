/datum/preference/choiced/voice_chime
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "voice_chime"

/datum/preference/choiced/voice_chime/init_possible_values()
	return list(
		"Voice 1",
		"Voice 2",
	)

	import { FeatureChoiced, FeatureDropdownInput } from "../base";

export const favorite_drink: FeatureChoiced = {
  name: "Voice",
  component: FeatureDropdownInput,
};
/datum/preference/choiced/voice_chime/apply_to_human(mob/living/carbon/human/target, value)
target.voice_chime = value
