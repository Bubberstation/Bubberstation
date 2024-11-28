//This is Bubberstation's special client preferences file, for flavor text. Background stuff like cultures will go here later.

//NSFW Flavor text, a way to let players express their NSFW side without having it be visible in their normal flavor text.
//TODO: Make this save to the mob rather than just be pulled from the client.
//TODO: Everytime I try currently, it makes the NSFW headshot overwrite the regular headshot, both of which aren't associated with this. It's super weird.


/datum/preferences
	var/headshot_nsfw = ""
	var/headshot_silicon = ""
	var/headshot_silicon_nsfw = ""

/datum/preference/text/flavor_text_nsfw
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text_nsfw"
	maximum_value_length = MAX_FLAVOR_LEN

//We want to make sure this is empty by default.
/datum/preference/text/flavor_text_nsfw/create_default_value()
	return ""

/datum/preference/text/flavor_text_nsfw/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["flavor_text_nsfw"] = value

//This is just a silicon variant of the NSFW flavor text.
/datum/preference/text/flavor_text_nsfw/silicon
	savefile_key = "silicon_flavor_text_nsfw"

/datum/preference/text/flavor_text_nsfw/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

//Lets the client choose when their NSFW flavor text is visible on a per-character basis.
/datum/preference/choiced/show_nsfw_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "show_flavor_text_nsfw"

/datum/preference/choiced/show_nsfw_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

//These are our options for when NSFW flavor text is shown. Always On = Always Visible, Nude Only means only when they are not wearing a uniform, and Never means it is never visible.
//These can be changed by clients on the fly.
/datum/preference/choiced/show_nsfw_flavor_text/init_possible_values()
	return list("Always On", "Nude Only", "Never")

/datum/preference/choiced/show_nsfw_flavor_text/create_default_value()
	return "Nude Only"

//NSFW headshot, so we can see those they/them nuts in the NSFW section of the character creator.
//TODO: Move the headshot proc over here so they stop overwriting each other by being a subtype.
/datum/preference/text/headshot/nsfw
	savefile_key = "headshot_nsfw"

/datum/preference/text/headshot/nsfw/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["headshot_nsfw"] = value

/datum/preference/text/headshot/nsfw/apply_headshot(value)
	if(stored_link[usr.ckey] != value)
		log_game("[usr] has set their NSFW Headshot image to '[value]'.")
	stored_link[usr?.ckey] = value
	usr?.client?.prefs.headshot_nsfw = value

//This is literally just the same as the original headshot pref but for silicons :)
/datum/preference/text/headshot/silicon
	savefile_key = "headshot_silicon"

/datum/preference/text/headshot/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/headshot/silicon/apply_headshot(value)
	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Think of it as a headshot for your ID. Lastly, [span_bold("do not use a real life photo or use any image that is less than serious.")]"))
		log_game("[usr] has set their Silicon Headshot image to '[value]'.")
	stored_link[usr?.ckey] = value
	usr?.client?.prefs.headshot_silicon = value

//Same as the original NSFW headshot pref, but for silicons.
/datum/preference/text/headshot/silicon/nsfw
	savefile_key = "headshot_silicon_nsfw"

/datum/preference/text/headshot/silicon/nsfw/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/headshot/silicon/nsfw/apply_headshot(value)
	if(stored_link[usr.ckey] != value)
		log_game("[usr] has set their NSFW Silicon Headshot image to '[value]'.")
	stored_link[usr?.ckey] = value
	usr?.client?.prefs.headshot_silicon_nsfw = value

//OOC notes for Silicons. Overwrites regular OOC notes when you are playing a Silicon character.
//TODO: Make this your regular OOC notes if you don't have Silicon ones. Every time I've tried, for some reason regular OOC notes haven't shown.
/datum/preference/text/ooc_notes/silicon
	savefile_key = "ooc_notes_silicon"

/datum/preference/text/ooc_notes/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

//Custom species and lore for silicons, also known as "Custom Model." This allows silicons to define a custom species rather than receiving, by default "A cyborg unit." BORING.
/datum/preference/text/custom_species/silicon
	savefile_key = "custom_species_silicon"

/datum/preference/text/custom_species/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/custom_species_lore/silicon
	savefile_key = "custom_species_lore_silicon"

/datum/preference/text/custom_species_lore/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

//Config entry for the Silicon flavor text requirement
/datum/config_entry/number/silicon_flavor_text_character_requirement
	default = 150
