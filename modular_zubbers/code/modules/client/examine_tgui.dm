/datum/examine_panel/ui_data(mob/user)
	var/list/data = ..()
	var/datum/preferences/preferences = holder.client?.prefs
	if(isnull(preferences))
		return ..()
	var/flavor_text_nsfw = ""
	var/headshot_nsfw = ""
	var/character_ad = ""
	var/emote_length = preferences.read_preference(/datum/preference/choiced/emote_length)
	var/approach = preferences.read_preference(/datum/preference/choiced/approach_pref)
	var/furries = preferences.read_preference(/datum/preference/choiced/directory_character_prefs/furry_pref)
	var/scalies = preferences.read_preference(/datum/preference/choiced/directory_character_prefs/scalie_pref)
	var/others = preferences.read_preference(/datum/preference/choiced/directory_character_prefs/other_pref)
	var/demihumans = preferences.read_preference(/datum/preference/choiced/directory_character_prefs/demihuman_pref)
	var/humans = preferences.read_preference(/datum/preference/choiced/directory_character_prefs/human_pref)
	var/show_nsfw_flavor_text = preferences.read_preference(/datum/preference/choiced/show_nsfw_flavor_text)
	if(issilicon(holder) && !(show_nsfw_flavor_text == "Never"))
		flavor_text_nsfw = preferences.read_preference(/datum/preference/text/flavor_text_nsfw/silicon)
		headshot_nsfw = preferences.read_preference(/datum/preference/text/headshot/silicon/nsfw)
	else if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		if((show_nsfw_flavor_text == "Always On") || (show_nsfw_flavor_text == "Nude Only" && !(holder_human.w_uniform)))
			flavor_text_nsfw = holder_human.dna.features["flavor_text_nsfw"]
			headshot_nsfw = holder_human.dna.features["headshot_nsfw"]
	character_ad += "Preferred Emote Length: [emote_length]\n"
	character_ad += "How to Approach: [approach]\n"
	character_ad += "Furries: [furries] | Scalies: [scalies] | Other: [others]\n"
	character_ad += "Demis: [demihumans] | Humans: [humans]\n"
	character_ad += "\n"
	character_ad += preferences.read_preference(/datum/preference/text/character_ad)

	data["character_ad"] = character_ad
	data["flavor_text_nsfw"] = flavor_text_nsfw
	data["headshot_nsfw"] = headshot_nsfw
	return data
