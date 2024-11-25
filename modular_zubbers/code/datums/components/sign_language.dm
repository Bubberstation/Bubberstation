/datum/component/sign_language/check_signables_state()
	. = ..()
	if(HAS_TRAIT(parent, TRAIT_SIGN_LANGUAGE_BLOCKED)) // BUBBER CHANGE add a trait to prevent sign language usage
		return SIGN_TRAIT_BLOCKED
