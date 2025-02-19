/datum/quirk/nameless
	name = "Nameless"
	desc = "You don't have a name. You are known only as a number."
	medical_record_text = "Subject lacks a name in records."
	value = 0
	icon = FA_ICON_USER_NINJA
	gain_text = span_notice("You feel your name slip away.")
	lose_text = span_notice("You spontaniously remember your full name!")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	var/character_name
	var/new_name

/datum/preference/text/nameless_quirk_option
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "nameless_quirk_name"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 20

/// Some sanity to ensure you can't have "     #1000" as your name.
/datum/preference/text/nameless_quirk_option/is_valid(value)
	if(isnull(value))
		return TRUE
	return !isnull(permissive_sanitize_name(value))

/datum/preference/text/nameless_quirk_option/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/nameless_quirk_option/deserialize(input, datum/preferences/preferences)
	return htmlrendertext(input)

/datum/preference/text/nameless_quirk_option/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/quirk_constant_data/nameless
	associated_typepath = /datum/quirk/nameless
	customization_options = list(
		/datum/preference/text/nameless_quirk_option
	)

/datum/quirk/nameless/add(client/client_source)
	character_name = client_source?.prefs.read_preference(/datum/preference/name/real_name)
	new_name = generate_name()
	quirk_holder.fully_replace_character_name(character_name, new_name)

/datum/quirk/nameless/remove()
	quirk_holder.fully_replace_character_name(new_name, character_name)

/datum/quirk/nameless/proc/generate_name()

	var/prefix = quirk_holder.client?.prefs.read_preference(/datum/preference/text/nameless_quirk_option)
	var/job
	var/number = pick(rand(1000, 9999))

	if(prefix)
		job = prefix
	else
		job = isnull(quirk_holder.job) ? pick("Alpha", "Beta", "Delta", "Echo", "Zulu", "Omega") : quirk_holder.job

	return "[job] #[number]"



