
/// Helper proc that checks if a human has a genital of a specific type and exposure state
/mob/living/carbon/human/proc/has_genital(required_state = REQUIRE_GENITAL_ANY, genital_slot)
	var/obj/item/organ/external/genital/genital = get_organ_slot(genital_slot)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return genital.is_exposed()
		if(REQUIRE_GENITAL_UNEXPOSED)
			return !genital.is_exposed()
		else
			return TRUE

/// Returns true if the human has an accessible penis for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_penis(required_state = REQUIRE_GENITAL_ANY)
	return has_genital(required_state, ORGAN_SLOT_PENIS)

/// Returns true if the human has accessible balls for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_balls(required_state = REQUIRE_GENITAL_ANY)
	return has_genital(required_state, ORGAN_SLOT_TESTICLES)

/// Returns true if the human has an accessible vagina for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_vagina(required_state = REQUIRE_GENITAL_ANY)
	return has_genital(required_state, ORGAN_SLOT_VAGINA)

/// Returns true if the human has accessible breasts for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_breasts(required_state = REQUIRE_GENITAL_ANY)
	return has_genital(required_state, ORGAN_SLOT_BREASTS)

/// Returns true if the human has an accessible anus for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_anus(required_state = REQUIRE_GENITAL_ANY)
	if(issilicon(src))
		return TRUE
	return has_genital(required_state, ORGAN_SLOT_ANUS)

/// Returns true if the human has an accessible butt for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_butt(required_state = REQUIRE_GENITAL_ANY)
	return has_genital(required_state, ORGAN_SLOT_BUTT)

/// Returns true if the human has an accessible belly for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_belly(required_state = REQUIRE_GENITAL_ANY)
	return has_genital(required_state, ORGAN_SLOT_BELLY)
