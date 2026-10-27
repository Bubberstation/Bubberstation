// This name means nothing. What does this even do?

/datum/status_effect/subspace
	id = "subspace"
	tick_interval = 1 SECONDS
	duration = 5 MINUTES
	alert_type = null

/datum/status_effect/subspace/on_apply()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.add_mood_event("subspace", /datum/mood_event/subspace)

/datum/status_effect/subspace/on_remove()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.clear_mood_event("subspace")

/datum/mood_event/subspace
	description = span_purple("Everything is so woozy... Pain feels so... Awesome.\n")


//Hips are red after spanking
/datum/status_effect/spanked
	id = "spanked"
	duration = 300 SECONDS
	alert_type = null

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(stat >= DEAD || HAS_TRAIT(src, TRAIT_FAKEDEATH) || src == user)
		return

	if(has_status_effect(/datum/status_effect/spanked) && is_bottomless())
		. += span_purple("[p_Their()] butt has a red tint to it.") + "\n"

	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp) || !user.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	if(has_penis(REQUIRE_GENITAL_EXPOSED))
		. += span_purple("[p_Their()] cock is exposed.") + "\n"
	if(has_vagina(REQUIRE_GENITAL_EXPOSED))
		. += span_purple("[p_Their()] vagina is exposed.") + "\n"
	if(has_breasts(REQUIRE_GENITAL_EXPOSED))
		. += span_purple("[p_Their()] breasts are exposed.") + "\n"
	if(has_anus(REQUIRE_GENITAL_EXPOSED))
		. += span_purple("[p_Their()] anus is exposed.") + "\n"

	if(cum_on_body)
		if(is_topless() || is_bottomless())
			. += span_purple("[p_They()] [p_are()] [get_lewd_coverage_string(cum_on_body)] [get_lewd_fluid_string(cum_on_body_type)].") + "\n"
		else
			. += span_purple("[p_Their()] clothes look damp and stained.") + "\n"
	if(cum_in_vagina && is_bottomless())
		. += span_purple("[capitalize(get_lewd_drip_text(cum_in_vagina_type, cum_in_vagina))] from [p_their()] vagina.") + "\n"
	if(cum_in_anus && is_bottomless())
		. += span_purple("[capitalize(get_lewd_drip_text(cum_in_anus_type, cum_in_anus))] from [p_their()] ass.") + "\n"

//Mood boost for masochist
/datum/mood_event/perv_spanked
	description = span_purple("Ah, yes! More! Punish me!\n")
	timeout = 5 MINUTES
