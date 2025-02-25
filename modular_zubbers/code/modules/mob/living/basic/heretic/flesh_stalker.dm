/mob/living/basic/heretic_summon/stalker/examine(mob/user)
	if(!HAS_TRAIT(src, TRAIT_DISGUISED))
		return ..()

	if(get_dist(user, src) <= 3) // The form won't hold up to close inspection.
		. += span_warning("It doesn't look quite right...")

// disguised stalkers will be untracked by non-sentient mobs wanting to kill them. I think.
/mob/living/basic/heretic_summon/stalker/can_track(mob/living/user)
	if(!HAS_TRAIT(src, TRAIT_DISGUISED))
		return FALSE
	return ..()

/mob/living/basic/heretic_summon/stalker/proc/on_disguise(mob/living/basic/user, atom/movable/target)
	SIGNAL_HANDLER

	//add some flavour
	visible_message(
		span_warning("[src] suddenly twists and changes shape, becoming a copy of [target]!"),
		span_notice("You twist your body and assume the form of [target]."),
	)

/// Do some more logic for the morph when we undisguise through the action.
/mob/living/basic/heretic_summon/stalker/proc/on_undisguise()
	SIGNAL_HANDLER

	//more flavour
	visible_message(
		span_warning("[src] suddenly collapses in on itself, dissolving into a pile of flesh and limbs!"),
		span_notice("You reform to your normal body."),
	)

// make sure they can't attack whilst disguised
/mob/living/basic/heretic_summon/stalker/early_melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(!.)
		return FALSE

	if(HAS_TRAIT(src, TRAIT_DISGUISED)) // && (melee_damage_disguised <= 0))
		balloon_alert(src, "can't attack while disguised!")
		return FALSE
	return ..()
