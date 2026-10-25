// Synthetic lewd support for cyborgs. Cyborgs use simplified synthetic anatomy rather
// than the organ-holder based system humans use, and their genitals can be configured
// from the Silicon section of character preferences and toggled live in-game.

// Generic defaults so the lewd code can call these on any living mob. Humans and
// cyborgs override them with their own anatomy checks.
/mob/living/proc/has_penis(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_vagina(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_breasts(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_anus(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_balls(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_arms(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/is_topless()
	return FALSE

/mob/living/proc/is_bottomless()
	return FALSE

/mob/living/proc/update_inv_lewd()
	return

/mob/living/proc/adjust_arousal(arous = 0)
	return FALSE

/mob/living/proc/climax(manual = TRUE)
	return FALSE

/mob/living/proc/has_required_part(slot)
	return FALSE

/mob/living/carbon/human/has_required_part(slot)
	var/obj/item/organ/genital/required_part = get_organ_slot(slot)
	if(isnull(required_part))
		return FALSE
	return required_part.is_exposed()

/mob/living/silicon/robot/has_required_part(slot)
	switch(slot)
		if(ORGAN_SLOT_VAGINA)
			return has_vagina(REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_PENIS)
			return has_penis(REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_BREASTS)
			return has_breasts(REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_ANUS)
			return has_anus(REQUIRE_GENITAL_EXPOSED)
	return FALSE

/mob/living/silicon/robot
	/// Synthetic genital configuration. These mirror the silicon genital prefs and can be toggled in-game.
	var/synthetic_vagina = FALSE
	var/synthetic_penis = FALSE
	var/synthetic_breasts = FALSE
	var/synthetic_anus = FALSE

/mob/living/silicon/robot/proc/apply_synthetic_genital_prefs(client/player_client)
	var/datum/preferences/preferences = player_client?.prefs
	if(!preferences)
		return

	synthetic_vagina = preferences.read_preference(/datum/preference/toggle/silicon_vagina)
	synthetic_penis = preferences.read_preference(/datum/preference/toggle/silicon_penis)
	synthetic_breasts = preferences.read_preference(/datum/preference/toggle/silicon_breasts)
	synthetic_anus = preferences.read_preference(/datum/preference/toggle/silicon_anus)
	update_inv_lewd()

/// Cyborgs have no organ holder. Return null so any generic organ-slot lookups safely no-op.
/mob/living/silicon/robot/get_organ_slot(slot)
	return null

/mob/living/silicon/robot/has_penis(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_penis)
		return FALSE
	if(required_state == REQUIRE_GENITAL_UNEXPOSED)
		return FALSE
	return TRUE

/mob/living/silicon/robot/has_vagina(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_vagina)
		return FALSE
	if(required_state == REQUIRE_GENITAL_UNEXPOSED)
		return FALSE
	return TRUE

/mob/living/silicon/robot/has_breasts(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_breasts)
		return FALSE
	if(required_state == REQUIRE_GENITAL_UNEXPOSED)
		return FALSE
	return TRUE

/mob/living/silicon/robot/has_anus(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_anus)
		return FALSE
	if(required_state == REQUIRE_GENITAL_UNEXPOSED)
		return FALSE
	return TRUE

/mob/living/silicon/robot/has_balls(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/// Cyborgs have manipulators, so treat their "hands" as always available for lewd interactions.
/mob/living/silicon/robot/has_arms(required_state = REQUIRE_GENITAL_ANY)
	return TRUE

/// Synthetic bodies are treated as exposed for lewd-slot purposes.
/mob/living/silicon/robot/is_topless()
	return TRUE

/mob/living/silicon/robot/is_bottomless()
	return TRUE

/// Cyborgs don't use the human overlay system; keeping this as a no-op is fine for now.
/mob/living/silicon/robot/update_inv_lewd()
	return

/mob/living/silicon/robot/adjust_arousal(arous = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE

	arousal = clamp(arousal + arous, AROUSAL_MINIMUM, AROUSAL_LIMIT)

	if(!has_status_effect(/datum/status_effect/aroused) && arousal)
		apply_status_effect(/datum/status_effect/aroused)

	if(arousal < AROUSAL_LOW)
		if(!arousal)
			remove_status_effect(/datum/status_effect/aroused)

	return TRUE

/mob/living/silicon/robot/adjust_pain(change_amount = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	pain = clamp(pain + change_amount, AROUSAL_MINIMUM, AROUSAL_LIMIT)

/mob/living/silicon/robot/climax(manual = TRUE)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE

	if(!has_penis() && !has_vagina())
		visible_message(span_purple("[src] twitches, but nothing happens."))
		return TRUE

	apply_status_effect(/datum/status_effect/climax)
	apply_status_effect(/datum/status_effect/climax_cooldown)
	try_lewd_autoemote("beep")
	return TRUE

/mob/living/silicon/robot/verb/configure_synthetic_anatomy()
	set name = "Configure Synthetic Anatomy"
	set category = "Robot Commands"
	set desc = "Toggle your cyborg's synthetic genital configuration."

	if(stat == DEAD)
		return

	if(!client?.prefs?.read_preference(/datum/preference/toggle/master_erp_preferences))
		to_chat(src, span_warning("ERP preferences are disabled for you."))
		return

	var/list/options = list(
		"synthetic vagina: [synthetic_vagina ? "ON" : "OFF"]",
		"synthetic penis: [synthetic_penis ? "ON" : "OFF"]",
		"synthetic breasts: [synthetic_breasts ? "ON" : "OFF"]",
		"synthetic anus: [synthetic_anus ? "ON" : "OFF"]",
	)

	var/choice = tgui_input_list(src, "Toggle a synthetic genital. Changes apply immediately and persist to your preferences.", "Configure Synthetic Anatomy", options)
	if(!choice)
		return

	if(findtext(choice, "vagina"))
		synthetic_vagina = !synthetic_vagina
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_vagina], synthetic_vagina)
	else if(findtext(choice, "penis"))
		synthetic_penis = !synthetic_penis
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_penis], synthetic_penis)
	else if(findtext(choice, "breasts"))
		synthetic_breasts = !synthetic_breasts
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_breasts], synthetic_breasts)
	else if(findtext(choice, "anus"))
		synthetic_anus = !synthetic_anus
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_anus], synthetic_anus)

	update_inv_lewd()
	to_chat(src, span_notice("Synthetic anatomy updated."))
