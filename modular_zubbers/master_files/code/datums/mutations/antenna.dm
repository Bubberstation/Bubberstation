/datum/action/cooldown/spell/pointed/mindread/cast(mob/living/cast_on)
	if(HAS_TRAIT(cast_on, TRAIT_PSIONIC_DAMPENER))
		to_chat(owner, span_warning("As you reach into [cast_on]'s mind, \
			you are stopped by a mental blockage."))
		return
	return ..()
