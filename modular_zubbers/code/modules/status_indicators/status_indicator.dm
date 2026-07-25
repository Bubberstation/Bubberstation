/obj/effect/overlay/status_indicator/
	icon = 'modular_zubbers/icons/mob/status_indicators.dmi'
	pixel_z = 16
	plane = ABOVE_GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 0

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/status_indicator)

/datum/component/status_indicator
	var/list/status_indicators = list() // Will become a list as needed. Contains our status indicator objects. Note, they are actually added to overlays, this just keeps track of what exists.
	var/mob/living/attached_mob

/// Returns true if the mob is weakened. Also known as floored.
/datum/component/status_indicator/proc/is_weakened()
	if(!indicator_fakeouts() && \
	attached_mob.IsKnockdown() || \
	HAS_TRAIT(attached_mob, TRAIT_FLOORED) && \
	!HAS_TRAIT_FROM(attached_mob, TRAIT_FLOORED, BUCKLED_TRAIT) && \
	!HAS_TRAIT(attached_mob, TRAIT_PRONE) // voluntary flooring
	)
		return TRUE

/// Returns true if the mob is stunned.
/datum/component/status_indicator/proc/is_stunned()
	if(!indicator_fakeouts() && \
	HAS_TRAIT_FROM(attached_mob, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT(attached_mob, TRAIT_CRITICAL_CONDITION) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT))
	)
		return TRUE

/// Returns true if the mob is paralyzed - for can't fight back purposes.
/datum/component/status_indicator/proc/is_paralyzed()
	if(!indicator_fakeouts() && \
	attached_mob.IsParalyzed() || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_FLOORED, CHOKEHOLD_TRAIT) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT(attached_mob, TRAIT_CRITICAL_CONDITION) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_INCAPACITATED, STAMINA))
		return TRUE

/// Returns true if the mob is unconcious for any reason.
/datum/component/status_indicator/proc/is_unconcious()
	if(!indicator_fakeouts() && HAS_TRAIT(attached_mob, TRAIT_KNOCKEDOUT))
		return TRUE

/// Returns true if the mob has confusion.
/datum/component/status_indicator/proc/is_confused()
	if(!indicator_fakeouts() && attached_mob.has_status_effect(/datum/status_effect/confusion))
		return TRUE

/datum/component/status_indicator/RegisterWithParent()
	attached_mob = parent
	RegisterSignals(parent, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_STATUS_STUN, COMSIG_LIVING_STATUS_KNOCKDOWN, COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_IMMOBILIZE, COMSIG_LIVING_STATUS_UNCONSCIOUS), PROC_REF(status_indicator_evaluate))


/datum/component/status_indicator/Destroy()
	QDEL_LIST_ASSOC_VAL(status_indicators)
	attached_mob = null
	. = ..()

/datum/component/status_indicator/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_STATUS_STUN, COMSIG_LIVING_STATUS_KNOCKDOWN, COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_IMMOBILIZE, COMSIG_LIVING_STATUS_UNCONSCIOUS))

/// Receives signals to update on carbon health updates. Checks if the mob is dead - if true, removes all the indicators. Then, we determine what status indicators the mob should carry or remove.
/datum/component/status_indicator/proc/status_indicator_evaluate()
	SIGNAL_HANDLER
	if(attached_mob.stat == DEAD)
		for(var/status_indicator_current in status_indicators)
			remove_status_indicator(status_indicator_current)
		return
	else
		weaken_indicator_update()
		paralyzed_indicator_update()
		stunned_indicator_update()
		unconcious_indicator_update()
		confused_indicator_update()
		return
/// Cases in which no status indicators should appear above a mob, such as changeling revive and regen coma.
/datum/component/status_indicator/proc/indicator_fakeouts()
	if(HAS_TRAIT(attached_mob, TRAIT_DEATHCOMA))
		return TRUE
	return FALSE

/datum/component/status_indicator/proc/weaken_indicator_update()
	SIGNAL_HANDLER
	is_weakened() ? add_status_indicator(WEAKEN) : remove_status_indicator(WEAKEN)
/datum/component/status_indicator/proc/paralyzed_indicator_update()
	SIGNAL_HANDLER
	is_paralyzed() ? add_status_indicator(PARALYSIS) : remove_status_indicator(PARALYSIS)
/datum/component/status_indicator/proc/stunned_indicator_update()
	SIGNAL_HANDLER
	is_stunned() ? add_status_indicator(STUNNED) : remove_status_indicator(STUNNED)
/datum/component/status_indicator/proc/unconcious_indicator_update()
	SIGNAL_HANDLER
	is_unconcious() ? add_status_indicator(SLEEPING) : remove_status_indicator(SLEEPING)
/datum/component/status_indicator/proc/confused_indicator_update()
	SIGNAL_HANDLER
	is_confused() ? add_status_indicator(CONFUSED) : remove_status_indicator(CONFUSED)

/// Adds a status indicator to the mob. If it exists, it won't dupe it.
/datum/component/status_indicator/proc/add_status_indicator(prospective_indicator)
	var/obj/effect/overlay/status_indicator/this_indicator
	if(!status_indicators[prospective_indicator])
		this_indicator = new
		this_indicator.icon_state = prospective_indicator
		status_indicators[prospective_indicator] = this_indicator
		animate_new_indicator(this_indicator)

/// Similar to add_status_indicator() but removes it instead, and nulls the list if it becomes empty as a result.
/datum/component/status_indicator/proc/remove_status_indicator(prospective_indicator)
	var/obj/effect/overlay/status_indicator/resolved_indicator = status_indicators[prospective_indicator]
	if(resolved_indicator)
		status_indicators[prospective_indicator] = null
		animate(resolved_indicator, pixel_z = rand(1,32), pixel_w = rand(1,32), time = 2 SECONDS, easing = LINEAR_EASING, alpha = 0)
		addtimer(CALLBACK(src, PROC_REF(cleanup), resolved_indicator), 3 SECONDS)

/datum/component/status_indicator/proc/cleanup(resolved_indicator)
	QDEL_IN(resolved_indicator, 2 SECONDS)
	attached_mob.vis_contents -= resolved_indicator

/// Refreshes the indicators over a mob's head. Should only be called when adding or removing a status indicator with the above procs,
/// or when the mob changes size visually for some reason.
/datum/component/status_indicator/proc/animate_new_indicator(obj/effect/overlay/status_indicator/this_indicator)


	var/mob/living/carbon/my_carbon_mob = attached_mob

	var/icon_scale = get_icon_scale(my_carbon_mob)
	this_indicator.pixel_z = rand(0,32)
	this_indicator.pixel_w = rand(0,32)
	if(my_carbon_mob.stat == DEAD)
		return

	// Now put them back on in the right spot.
	var/our_sprite_x = 16 * icon_scale
	var/our_sprite_y = 24 * icon_scale

	var/x_offset = our_sprite_x // Add your own offset here later if you want.
	var/y_offset = our_sprite_y + STATUS_INDICATOR_Y_OFFSET

	// Calculates how 'long' the row of indicators and the margin between them should be.
	// The goal is to have the center of that row be horizontally aligned with the sprite's center.
	var/expected_status_indicator_length = (STATUS_INDICATOR_ICON_X_SIZE * status_indicators.len) + (STATUS_INDICATOR_ICON_MARGIN * max(status_indicators.len - 1, 0))
	var/current_x_position = (x_offset / 2) - (expected_status_indicator_length / 2)

	// In /mob/living's `update_transform()`, the sprite is horizontally shifted when scaled up, so that the center of the sprite doesn't move to the right.
	// Because of that, this adjustment needs to happen with the future indicator row as well, or it will look bad.
	current_x_position -= 16 * (icon_scale - DEFAULT_MOB_SCALE)
	this_indicator.appearance_flags |= (KEEP_TOGETHER|RESET_COLOR|RESET_TRANSFORM)
	my_carbon_mob.vis_contents |= this_indicator

	animate(this_indicator, pixel_z = y_offset, pixel_w = current_x_position, time = 1 SECONDS, easing = BOUNCE_EASING, alpha = 255)

/datum/component/status_indicator/proc/get_icon_scale(livingmob)
	if(!iscarbon(livingmob)) // normal mobs are always 1 for scale - hopefully all borgs and simplemobs get this one
		return DEFAULT_MOB_SCALE
	var/mob/living/carbon/passed_mob = livingmob // we're possibly a player! We have size prefs!
	var/mysize = (passed_mob.dna?.current_body_size ? passed_mob.dna.current_body_size : DEFAULT_MOB_SCALE)
	return mysize


#undef STATUS_INDICATOR_Y_OFFSET
#undef STATUS_INDICATOR_ICON_X_SIZE
#undef STATUS_INDICATOR_ICON_MARGIN
