GLOBAL_DATUM(character_directory, /datum/character_directory)
GLOBAL_LIST_INIT(char_directory_tags, list("Pred", "Pred-Pref", "Prey", "Prey-Pref", "Switch", "Non-Vore", "Unset"))
GLOBAL_LIST_INIT(char_directory_erptags, list("Top", "Bottom", "Switch", "No ERP", "Unset"))

/client
	COOLDOWN_DECLARE(char_directory_cooldown)

/client/verb/show_character_directory()
	set name = "Character Directory"
	set category = "OOC"
	set desc = "Shows a listing of all active characters, along with their associated OOC notes, flavor text, and more."

	// This is primarily to stop malicious users from trying to lag the server by spamming this verb
	if(!COOLDOWN_FINISHED(src, char_directory_cooldown))
		to_chat(src, span_alert("Hold your horses! Its still refreshing!"))
		return
	COOLDOWN_START(src, char_directory_cooldown, 10)

	if(!GLOB.character_directory)
		GLOB.character_directory = new
	GLOB.character_directory.ui_interact(mob)

// This is a global singleton. Keep in mind that all operations should occur on user, not src.
/datum/character_directory

/datum/character_directory/ui_state(mob/user)
	return GLOB.always_state

/datum/character_directory/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ZubbersCharacterDirectory", "Character Directory")
		ui.open()

/datum/character_directory/ui_data(mob/user)
	. = ..()
	var/list/data = .

	if (user?.client?.prefs)
		data["personalVisibility"] = user.client.prefs.read_preference(/datum/preference/toggle/show_in_directory)
		data["personalTag"] = user.client.prefs.read_preference(/datum/preference/choiced/erp_status_v) || "Unset"
		data["personalErpTag"] = user.client.prefs.read_preference(/datum/preference/choiced/erp_status) || "Unset"
		data["prefsOnly"] = TRUE

	data["canOrbit"] = isobserver(user)

	return data

/datum/character_directory/ui_static_data(mob/user)
	. = ..()
	var/list/data = .

	var/list/directory_mobs = list()
	for(var/mob/mob in GLOB.alive_mob_list)
		// Allow opt-out and filter players not in the game
		// if(!player_client.prefs.show_in_directory)
		// 	continue

		// These are the three vars we're trying to find
		// The approach differs based on the mob the client is controlling
		var/name = null
		var/species = null
		var/ooc_notes = null
		var/flavor_text = null
		var/tag
		var/erptag
		var/character_ad
		var/ref = REF(mob)
		if(!mob)
			continue

		if(ishuman(mob))
			var/mob/living/carbon/human/human = mob
			if((human.wear_mask && (human.wear_mask.flags_inv & HIDEFACE)) || (human.head && (human.head.flags_inv & HIDEFACE)) || (HAS_TRAIT(human, TRAIT_UNKNOWN)))
				continue
			species = "[human.dna.species.name ? mob.client.prefs.read_preference(/datum/preference/text/custom_species) : human.dna.species]"
			if(!human.client.prefs.read_preference(/datum/preference/text/custom_species))
				species = "[human.dna.species.name]"
		else if(issilicon(mob))
			var/mob/living/silicon/silicon = mob
			species = silicon.client.prefs.read_preference(/datum/preference/choiced/brain_type)
		else
			continue
		tag = mob.client.prefs.read_preference(/datum/preference/choiced/erp_status_v) || "Unset"
		erptag = mob.client.prefs.read_preference(/datum/preference/choiced/erp_status) || "Unset"
		character_ad = mob.client.prefs.read_preference(/datum/preference/text/character_ad) || "Unset"
		name = mob.real_name ? mob.name : mob.real_name
		ooc_notes = mob.client.prefs.read_preference(/datum/preference/text/ooc_notes)
		flavor_text = mob.client.prefs.read_preference(/datum/preference/text/flavor_text)

		directory_mobs.Add(list(list(
			"name" = name,
			"species" = species,
			"ooc_notes" = ooc_notes,
			"tag" = tag,
			"erptag" = erptag,
			"character_ad" = character_ad,
			"flavor_text" = flavor_text,
			"ref" = ref
		)))

	data["directory"] = directory_mobs

	return data

/datum/character_directory/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	var/mob/user = usr
	if(!user)
		return

	switch(action)
		if("refresh")
			// This is primarily to stop malicious users from trying to lag the server by spamming this verb
			if(!COOLDOWN_FINISHED(user.client, char_directory_cooldown))
				to_chat(user, "<span class='warning'>Don't spam character directory refresh.</span>")
				return
			COOLDOWN_START(user.client, char_directory_cooldown, 10)
			update_static_data(user, ui)
			return TRUE
		if("orbit")
			var/ref = params["ref"]
			var/mob/dead/observer/ghost = user
			var/atom/movable/poi = (locate(ref) in GLOB.mob_list)
			if (poi == null)
				return TRUE
			ghost.ManualFollow(poi)
			ghost.reset_perspective(null)
			return TRUE
