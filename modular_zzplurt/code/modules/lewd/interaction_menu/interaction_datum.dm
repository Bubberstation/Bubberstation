/datum/interaction
	/// Which genital the interaction cums with (must be penis, vagina or both)
	var/list/cum_genital = list(CLIMAX_POSITION_USER = null, CLIMAX_POSITION_TARGET = null)
	/// Where on the partner the interaction cums in? (It must match a genital's ORGAN_SLOT, mouth or sheath)
	var/list/cum_target = list(CLIMAX_POSITION_USER = null, CLIMAX_POSITION_TARGET = null)
	/// override of the text to display when the interaction cums (use this if you're not using a cum_target)
	var/list/cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(), CLIMAX_POSITION_TARGET = list())
	/// override of the self message to display when the interaction cums (use this if you're not using a cum_target)
	var/list/cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(), CLIMAX_POSITION_TARGET = list())
	/// override of the text to display to the partner when the interaction cums (use this if you're not using a cum_target)
	var/list/cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(), CLIMAX_POSITION_TARGET = list())
	/// Is the interaction considered extreme/harmful/unholy?
	var/unsafe_types = NONE

/datum/interaction/load_from_json(path)
	. = ..()
	if(!.)
		return FALSE

	var/list/unsafe_flags = list(
		"extreme" = INTERACTION_EXTREME,
		"extremeharm" = INTERACTION_EXTREME | INTERACTION_HARMFUL,
		"unholy" = INTERACTION_UNHOLY,
	)

	var/list/json = json_decode(file2text(path))
	cum_genital[CLIMAX_POSITION_USER] = sanitize_text(json["cum_genital_user"])
	cum_genital[CLIMAX_POSITION_TARGET] = sanitize_text(json["cum_genital_target"])
	cum_target[CLIMAX_POSITION_USER] = sanitize_text(json["cum_target_user"])
	cum_target[CLIMAX_POSITION_TARGET] = sanitize_text(json["cum_target_target"])
	cum_message_text_overrides[CLIMAX_POSITION_USER] = sanitize_islist(json["cum_message_text_overrides_user"], list())
	cum_message_text_overrides[CLIMAX_POSITION_TARGET] = sanitize_islist(json["cum_message_text_overrides_target"], list())
	cum_self_text_overrides[CLIMAX_POSITION_USER] = sanitize_islist(json["cum_self_text_overrides_user"], list())
	cum_self_text_overrides[CLIMAX_POSITION_TARGET] = sanitize_islist(json["cum_self_text_overrides_target"], list())
	cum_partner_text_overrides[CLIMAX_POSITION_USER] = sanitize_islist(json["cum_partner_text_overrides_user"], list())
	cum_partner_text_overrides[CLIMAX_POSITION_TARGET] = sanitize_islist(json["cum_partner_text_overrides_target"], list())

	var/list/unsafe_list = sanitize_islist(json["unsafe_types"], list())
	for(var/unsafe_type in unsafe_list)
		unsafe_types |= unsafe_flags[unsafe_type]

/datum/interaction/proc/allow_act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target == user && usage == INTERACTION_OTHER)
		return FALSE

	if(unsafe_types & INTERACTION_EXTREME)
		if(!(user.client?.prefs?.read_preference(/datum/preference/choiced/erp_status_extm) != "No") || !(target.client?.prefs?.read_preference(/datum/preference/choiced/erp_status_extm) != "No"))
			return FALSE
	if(unsafe_types & INTERACTION_HARMFUL)
		if(!(user.client?.prefs?.read_preference(/datum/preference/choiced/erp_status_extmharm) != "No") || !(target.client?.prefs?.read_preference(/datum/preference/choiced/erp_status_extmharm) != "No"))
			return FALSE
	if(unsafe_types & INTERACTION_UNHOLY)
		if(!(user.client?.prefs?.read_preference(/datum/preference/choiced/erp_status_unholy) != "No") || !(target.client?.prefs?.read_preference(/datum/preference/choiced/erp_status_unholy) != "No"))
			return FALSE

	if(user_required_parts.len)
		for(var/slot in user_required_parts)
			if(!user.has_genital(LAZYACCESS(user_required_parts, slot) || REQUIRE_GENITAL_EXPOSED, slot))
				return FALSE

	if(target_required_parts.len)
		for(var/slot in target_required_parts)
			if(!target.has_genital(LAZYACCESS(target_required_parts, slot) || REQUIRE_GENITAL_EXPOSED, slot))
				return FALSE

	for(var/requirement in interaction_requires)
		switch(requirement)
			if(INTERACTION_REQUIRE_SELF_HAND)
				if(!user.get_active_hand())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_HAND)
				if(!target.get_active_hand())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_MOUTH)
				if(!user.get_bodypart(BODY_ZONE_PRECISE_MOUTH) || user.is_mouth_covered())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_MOUTH)
				if(!target.get_bodypart(BODY_ZONE_PRECISE_MOUTH) || target.is_mouth_covered())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_TOPLESS)
				if(!user.is_topless())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_TOPLESS)
				if(!target.is_topless())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_BOTTOMLESS)
				if(!user.is_bottomless())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_BOTTOMLESS)
				if(!target.is_bottomless())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_FEET)
				if(!(user.has_feet() >= (LAZYACCESS(user_required_parts, INTERACTION_REQUIRE_SELF_FEET) || 2))) //We prolly don't need to care if it's exposed or not
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_FEET)
				if(!(target.has_feet() >= (LAZYACCESS(target_required_parts, INTERACTION_REQUIRE_TARGET_FEET) || 2)))
					return FALSE
			else
				CRASH("Unimplemented interaction requirement '[requirement]'")
	return TRUE

/// Called when the interaction is performed
/datum/interaction/proc/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

// Called when either the user or target is cumming from the interaction, makes the interaction text
/datum/interaction/proc/show_climax(mob/living/carbon/human/cumming, mob/living/carbon/human/came_in, position)
	var/override_check = length(cum_message_text_overrides[position]) && length(cum_self_text_overrides[position]) && length(cum_partner_text_overrides[position])
	if(!override_check)
		return FALSE

	var/cumming_their = cumming.p_their()
	var/cumming_them = cumming.p_them()
	var/came_in_them = came_in.p_them()
	var/came_in_their = came_in.p_their()
	var/genital_used = cum_genital[position]
	var/hole_used = cum_target[position]

	if(override_check)
		var/message = pick(cum_message_text_overrides[position])
		message = replacetext(message, "%CUMMING%", "[cumming]")
		message = replacetext(message, "%CUMMING_THEIR%", "[cumming_their]")
		message = replacetext(message, "%CUMMING_THEM%", "[cumming_them]")
		message = replacetext(message, "%CAME_IN%", "[came_in]")
		message = replacetext(message, "%CAME_IN_THEIR%", "[came_in_their]")
		message = replacetext(message, "%CAME_IN_THEM%", "[came_in_them]")
		message = replacetext(message, "%CUM_GENITAL%", "[genital_used]")
		message = replacetext(message, "%CUM_TARGET%", "[hole_used]")

		var/self_message = pick(cum_self_text_overrides[position])
		self_message = replacetext(self_message, "%CUMMING%", "[cumming]")
		self_message = replacetext(self_message, "%CUMMING_THEIR%", "[cumming_their]")
		self_message = replacetext(self_message, "%CUMMING_THEM%", "[cumming_them]")
		self_message = replacetext(self_message, "%CAME_IN%", "[came_in]")
		self_message = replacetext(self_message, "%CAME_IN_THEIR%", "[came_in_their]")
		self_message = replacetext(self_message, "%CAME_IN_THEM%", "[came_in_them]")
		self_message = replacetext(self_message, "%CUM_GENITAL%", "[genital_used]")
		self_message = replacetext(self_message, "%CUM_TARGET%", "[hole_used]")

		var/partner_message = pick(cum_partner_text_overrides[position])
		partner_message = replacetext(partner_message, "%CUMMING%", "[cumming]")
		partner_message = replacetext(partner_message, "%CUMMING_THEIR%", "[cumming_their]")
		partner_message = replacetext(partner_message, "%CUMMING_THEM%", "[cumming_them]")
		partner_message = replacetext(partner_message, "%CAME_IN%", "[came_in]")
		partner_message = replacetext(partner_message, "%CAME_IN_THEIR%", "[came_in_their]")
		partner_message = replacetext(partner_message, "%CAME_IN_THEM%", "[came_in_them]")
		partner_message = replacetext(partner_message, "%CUM_GENITAL%", "[genital_used]")
		partner_message = replacetext(partner_message, "%CUM_TARGET%", "[hole_used]")

		cumming.visible_message(span_userlove(message), span_userlove(self_message))
		to_chat(came_in, span_userlove(partner_message))
		return TRUE

/// Called after either the user or target cums from the interaction
/datum/interaction/proc/post_climax(mob/living/carbon/human/cumming, mob/living/carbon/human/came_in, position)
	return
