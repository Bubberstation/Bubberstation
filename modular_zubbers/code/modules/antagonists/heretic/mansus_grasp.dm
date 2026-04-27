/datum/action/cooldown/spell/touch/mansus_grasp
	desc = "A touch spell that lets you channel the power of the Old Gods through your grip. Requires a Living Heart to use for anything except runes."

/datum/action/cooldown/spell/touch/mansus_grasp/can_hit_with_hand(atom/victim, mob/living/caster)
	. = ..()
	if (!.)
		return FALSE
	if (caster.has_status_effect(/datum/status_effect/void_stealth))
		return FALSE
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(caster)
	if (!isturf(victim) && heretic_datum?.has_living_heart() != HERETIC_HAS_LIVING_HEART)
		caster.balloon_alert(caster, "can only draw runes with no living heart!")
		return FALSE
