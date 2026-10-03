// Shared Interaction Menu / Scene Assistant helpers on /mob/living.

/mob/living/proc/get_played_character_slot()
	if(rp_panel?.character_slot)
		return rp_panel.character_slot
	var/slot = 0
	if(mind?.original_character_slot_index)
		slot = mind.original_character_slot_index
	else
		slot = find_character_slot_by_name()
	if(slot && rp_panel)
		rp_panel.character_slot = slot
	return slot

/mob/living/proc/find_character_slot_by_name()
	var/datum/preferences/prefs = client?.prefs
	if(!prefs?.savefile)
		return 0
	var/mob_name = real_name || name
	if(!mob_name)
		return 0
	for(var/slot in 1 to prefs.max_save_slots)
		var/list/save_data = prefs.savefile.get_entry("character[slot]")
		if(!islist(save_data))
			continue
		if(save_data["real_name"] == mob_name)
			return slot
	return 0

/mob/living/proc/prefs_cache_belongs_to_mob(datum/preferences/prefs)
	if(!prefs?.value_cache)
		return FALSE
	var/cached_name = prefs.value_cache[/datum/preference/name/real_name]
	if(!cached_name)
		return FALSE
	return cached_name == (real_name || name)

/mob/living/proc/read_character_preference(pref_type)
	var/datum/preferences/prefs = client?.prefs
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return null
	if(preference_entry.savefile_identifier != PREFERENCE_CHARACTER)
		return prefs?.read_preference(pref_type)
	var/slot = get_played_character_slot()
	if(slot && prefs?.savefile)
		var/list/save_data = prefs.savefile.get_entry("character[slot]")
		var/value = preference_entry.read(save_data, prefs)
		if(!isnull(value))
			return value
	return preference_entry.create_interaction_fallback_value(src)

/mob/living/proc/write_character_preference(pref_type, value)
	var/datum/preferences/prefs = client?.prefs
	if(!prefs)
		return FALSE
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return FALSE
	if(preference_entry.savefile_identifier != PREFERENCE_CHARACTER)
		if(!prefs.write_preference(preference_entry, value))
			return FALSE
		prefs.recently_updated_keys |= preference_entry.type
		prefs.save_preferences()
		return TRUE
	var/slot = get_played_character_slot()
	if(!slot)
		return FALSE
	var/tree_key = "character[slot]"
	var/list/save_data = prefs.savefile.get_entry(tree_key)
	if(isnull(save_data))
		prefs.savefile.set_entry(tree_key, list())
		save_data = prefs.savefile.get_entry(tree_key)
	var/new_value = preference_entry.deserialize(value, prefs)
	if(!preference_entry.write(save_data, new_value, prefs))
		return FALSE
	if(prefs.default_slot == slot && prefs_cache_belongs_to_mob(prefs))
		prefs.value_cache[preference_entry.type] = new_value
	prefs.savefile.save()
	return TRUE

/mob/living/proc/erp_prefs_enabled()
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	return client?.prefs?.read_preference(/datum/preference/toggle/master_erp_preferences) && client.prefs.read_preference(/datum/preference/toggle/erp)

/mob/living/proc/get_interaction_headshot()
	if(client?.ckey)
		var/datum/preference/text/headshot/pref = GLOB.preference_entries[/datum/preference/text/headshot]
		if(pref?.stored_link)
			return pref.stored_link[client.ckey] || ""
	return ""

/mob/living/carbon/human/get_interaction_headshot()
	return dna?.features["headshot"] || ""

/// Maps an ERP choiced preference string to a short UI status label.
/proc/erp_preference_status_label(choice)
	if(!choice || choice == "No" || choice == "None")
		return "NO"
	if(findtext(choice, "Ask"))
		return "L(OOC)"
	if(findtext(choice, "Check"))
		return "NOTE"
	return "YES"

/mob/living/proc/build_interaction_anatomy_details()
	return list()

/mob/living/carbon/human/build_interaction_anatomy_details()
	var/list/details = list()
	if(has_arms(REQUIRE_GENITAL_ANY) > 0)
		details += is_hands_uncovered() ? "has covered hands" : "has uncovered hands"
	if(has_feet(REQUIRE_GENITAL_ANY) > 0)
		if(is_barefoot() && (!socks || socks == "Nude" || (underwear_visibility & UNDERWEAR_HIDE_SOCKS)))
			details += "is barefoot"
		else if(is_barefoot())
			details += "is wearing socks"
		else
			details += "has feet covered"
	var/obj/item/bodypart/head/head_part = get_bodypart(BODY_ZONE_HEAD)
	if(head_part)
		var/mouth_covered = (wear_mask?.flags_inv & HIDEFACE) || (head?.flags_inv & HIDEFACE)
		details += mouth_covered ? "has a mouth, which is covered" : "has a mouth, which is uncovered"
	details += is_head_uncovered() ? "has head covered" : "has head uncovered"
	if(is_topless() && is_bottomless())
		details += "is naked"
	else if(is_topless())
		details += "is topless"
	else if(is_bottomless())
		details += "is bottomless"
	var/static/list/genital_lines = list(
		ORGAN_SLOT_PENIS = "has a penis",
		ORGAN_SLOT_TESTICLES = "has testicles",
		ORGAN_SLOT_VAGINA = "has a vagina",
		ORGAN_SLOT_BREASTS = "has breasts",
		ORGAN_SLOT_ANUS = "has an anus",
	)
	for(var/slot in genital_lines)
		var/obj/item/organ/genital/genital = get_organ_slot(slot)
		if(istype(genital) && genital.is_exposed())
			details += genital_lines[slot]
	return details

/mob/living/proc/build_interaction_status_tags()
	var/list/tags = list()
	if(!client?.prefs)
		return tags
	tags += list(list("label" = "ERP", "value" = erp_preference_status_label(read_character_preference(/datum/preference/choiced/erp_status))))
	tags += list(list("label" = "HYPNOSIS", "value" = erp_preference_status_label(read_character_preference(/datum/preference/choiced/erp_status_hypno))))
	tags += list(list("label" = "VORE", "value" = erp_preference_status_label(read_character_preference(/datum/preference/choiced/erp_status_v))))
	tags += list(list("label" = "NON-CON", "value" = erp_preference_status_label(read_character_preference(/datum/preference/choiced/erp_status_nc))))
	var/mechanics = read_character_preference(/datum/preference/choiced/erp_status_mechanics)
	tags += list(list("label" = "MECHANICS", "value" = (!mechanics || mechanics == "None") ? "NO" : uppertext(mechanics)))
	return tags

/mob/living/proc/build_interaction_self_data()
	return list(
		"show_erp" = erp_prefs_enabled(),
		"autocum" = FALSE,
		"inactive" = FALSE,
		"prefs" = list(),
		"genitals" = list(),
		"underwear" = list(),
	)

/mob/living/carbon/human/build_interaction_self_data()
	var/list/data = ..()
	data["underwear"] = list(
		"underwear" = !!(underwear_visibility & UNDERWEAR_HIDE_UNDIES),
		"bra" = !!(underwear_visibility & UNDERWEAR_HIDE_BRA),
		"undershirt" = !!(underwear_visibility & UNDERWEAR_HIDE_SHIRT),
		"socks" = !!(underwear_visibility & UNDERWEAR_HIDE_SOCKS),
	)
	if(!data["show_erp"] || !client?.prefs)
		return data
	data["autocum"] = client.prefs.read_preference(/datum/preference/toggle/erp/autocum)
	var/static/list/pref_map = list(
		"erp_status" = /datum/preference/choiced/erp_status,
		"erp_status_nc" = /datum/preference/choiced/erp_status_nc,
		"erp_status_v" = /datum/preference/choiced/erp_status_v,
		"erp_status_hypno" = /datum/preference/choiced/erp_status_hypno,
		"erp_status_mechanics" = /datum/preference/choiced/erp_status_mechanics,
	)
	var/list/pref_payload = list()
	for(var/key in pref_map)
		var/datum/preference/choiced/pref = GLOB.preference_entries[pref_map[key]]
		pref_payload[key] = list(
			"value" = read_character_preference(pref_map[key]),
			"options" = pref.get_choices(),
		)
	data["prefs"] = pref_payload
	var/static/list/genital_slots = list(
		ORGAN_SLOT_PENIS = "Penis",
		ORGAN_SLOT_TESTICLES = "Testicles",
		ORGAN_SLOT_VAGINA = "Vagina",
		ORGAN_SLOT_ANUS = "Anus",
		ORGAN_SLOT_BREASTS = "Breasts",
	)
	var/list/genitals = list()
	for(var/slot in genital_slots)
		var/obj/item/organ/genital/genital = get_organ_slot(slot)
		if(!istype(genital) || genital.visibility_preference == GENITAL_SKIP_VISIBILITY)
			continue
		genitals += list(list(
			"slot" = slot,
			"name" = genital_slots[slot],
			"visibility" = genital.visibility_preference,
		))
	data["genitals"] = genitals
	return data

/mob/living/proc/set_interaction_self_preference(pref_type, pref_value)
	if(!client?.prefs || !pref_type || isnull(pref_value) || !erp_prefs_enabled())
		return
	var/static/list/pref_map = list(
		"erp_status" = /datum/preference/choiced/erp_status,
		"erp_status_nc" = /datum/preference/choiced/erp_status_nc,
		"erp_status_v" = /datum/preference/choiced/erp_status_v,
		"erp_status_hypno" = /datum/preference/choiced/erp_status_hypno,
		"erp_status_mechanics" = /datum/preference/choiced/erp_status_mechanics,
	)
	var/pref_path = pref_map[pref_type]
	if(!pref_path)
		return
	write_character_preference(pref_path, pref_value)

/mob/living/proc/set_interaction_genital_visibility(organ_slot, visibility)
	return

/mob/living/carbon/human/set_interaction_genital_visibility(organ_slot, visibility)
	if(!organ_slot)
		return
	if(!(visibility in list(GENITAL_NEVER_SHOW, GENITAL_HIDDEN_BY_CLOTHES, GENITAL_ALWAYS_SHOW)))
		return
	var/obj/item/organ/genital/genital = get_organ_slot(organ_slot)
	if(!genital)
		return
	genital.visibility_preference = visibility
	update_body()
	SEND_SIGNAL(src, COMSIG_HUMAN_TOGGLE_GENITALS)

/mob/living/proc/toggle_interaction_underwear(kind)
	return

/mob/living/carbon/human/toggle_interaction_underwear(kind)
	switch(kind)
		if("underwear")
			underwear_visibility ^= UNDERWEAR_HIDE_UNDIES
		if("bra")
			underwear_visibility ^= UNDERWEAR_HIDE_BRA
		if("undershirt")
			underwear_visibility ^= UNDERWEAR_HIDE_SHIRT
		if("socks")
			underwear_visibility ^= UNDERWEAR_HIDE_SOCKS
		else
			return
	update_body()
	SEND_SIGNAL(src, COMSIG_HUMAN_TOGGLE_UNDERWEAR, kind)

/datum/preference/proc/create_interaction_fallback_value(mob/living/target)
	return create_default_value()
