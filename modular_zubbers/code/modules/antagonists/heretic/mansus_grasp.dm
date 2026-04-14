/datum/action/cooldown/spell/touch/mansus_grasp/can_hit_with_hand(atom/victim, mob/living/caster)
	. = ..()
	if (!.)
		return FALSE
	if (caster.has_status_effect(/datum/status_effect/void_stealth))
		return FALSE
