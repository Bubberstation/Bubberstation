/**
 *	MEZMERIZE
 *	 Locks a target in place for a certain amount of time.
 *
 * 	Level 2: Additionally mutes
 * 	Level 3: Can be used through face protection
 * 	Level 5: Doesn't need to be facing you anymore
 */

#define MESMERIZE_MUTE_LEVEL 2
/datum/action/cooldown/bloodsucker/targeted/mesmerize
	name = "Mesmerize"
	desc = "Dominate the mind of a mortal who can see your eyes."
	button_icon_state = "power_mez"
	power_flags = NONE
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|VASSAL_CAN_BUY
	bloodcost = 30
	cooldown_time = 30 SECONDS
	target_range = 8
	power_activates_immediately = FALSE
	unset_after_click = FALSE
	prefire_message = "Whom will you subvert to your will?"
	///Our mesmerized target - Prevents several mesmerizes.
	var/datum/weakref/target_ref
	/// How long it takes us to mesmerize our target.
	var/mesmerize_delay = 4 SECONDS
	/// At what level this ability will blind the target at. Level 0 = never.
	var/blind_at_level = 0
	var/requires_facing_target = TRUE
	var/blocked_by_glasses = TRUE
	var/image/current_overlay

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_explanation()
	return "[level_current]: src: \n\
		Click any player to attempt to mesmerize them. This will stun them for [DisplayTimeText(get_power_time())].\n\
		You cannot wear anything covering your face, and both parties must be facing eachother. Obviously, both parties need to not be blind. \n\
		Right clicking with the ability will apply a knockdown, but will also confuse your victim.\n\
		If your target is already mesmerized or a Monster Hunter, the Power will fail.\n\
		Once mesmerized, the target will be unable to move for a certain amount of time, scaling with level.\n\
		At level 2, your target will additionally be muted for [DisplayTimeText(get_mute_time())].\n\
		At level 3, you will be able to use the power through items covering your face.\n\
		At level 5, you will be able to mesmerize regardless of your target's direction.\n\
		Higher levels will increase the time of the mesmerize's freeze.\n\
		Additionally it works on silicon lifeforms, causing a EMP effect instead of a freeze."

/datum/action/cooldown/bloodsucker/targeted/mesmerize/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.) // Default checks
		return FALSE
	if(!user.get_organ_slot(ORGAN_SLOT_EYES))
		// Cant use balloon alert, they've got no eyes!
		to_chat(user, span_warning("You have no eyes with which to mesmerize."))
		return FALSE
	// Check: Eyes covered?
	if(blocked_by_glasses && istype(user) && (user.is_eyes_covered() && level_current <= 2) || !isturf(user.loc))
		user.balloon_alert(user, "your eyes are concealed from sight.")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return isliving(target_atom)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/CheckCanTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/current_target = target_atom // We already know it's carbon due to CheckValidTarget()
	// No mind
	if(!current_target.mind)
		owner.balloon_alert(owner, "[current_target] is mindless.")
		return FALSE
	// Bloodsucker
	if(IS_BLOODSUCKER(current_target))
		owner.balloon_alert(owner, "bloodsuckers are immune to [src].")
		return FALSE
	// Dead/Unconscious
	if(current_target.stat > CONSCIOUS)
		owner.balloon_alert(owner, "[current_target] is not [(current_target.stat == DEAD || HAS_TRAIT(current_target, TRAIT_FAKEDEATH)) ? "alive" : "conscious"].")
		return FALSE
	// Target has eyes?
	if(!current_target.get_organ_slot(ORGAN_SLOT_EYES) && !issilicon(current_target))
		owner.balloon_alert(owner, "[current_target] has no eyes.")
		return FALSE
	// Target blind?
	if(current_target.is_blind() && !issilicon(current_target))
		owner.balloon_alert(owner, "[current_target] is blind.")
		return FALSE
	// Facing target?
	if(requires_facing_target && !is_source_facing_target(owner, current_target)) // in unsorted.dm
		owner.balloon_alert(owner, "you must be facing [current_target].")
		return FALSE
	// Target facing me? (On the floor, they're facing everyone)
	if(((current_target.mobility_flags & MOBILITY_STAND) && requires_facing_target && !is_source_facing_target(current_target, owner) && level_current <= 4))
		owner.balloon_alert(owner, "[current_target] must be facing you.")
		return FALSE

	// Gone through our checks, let's mark our guy.
	target_ref = WEAKREF(current_target)
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/FireTargetedPower(atom/target, params)
	cast_mesmerize(target, params)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/cast_mesmerize(atom/target, params)
	var/mob/living/user = owner
	var/mob/living/carbon/mesmerized_target = target_ref?.resolve()
	if(!mesmerized_target)
		CRASH("mesmerized_target is null")

	if(issilicon(mesmerized_target))
		var/mob/living/silicon/mesmerized = mesmerized_target
		mesmerized.emp_act(EMP_HEAVY)
		owner.balloon_alert(owner, "temporarily shut [mesmerized] down.")
		PowerActivatedSuccesfully() // PAY COST! BEGIN COOLDOWN!
		return
	if(istype(mesmerized_target))
		owner.balloon_alert(owner, "attempting to hypnotically gaze [mesmerized_target]...")
		if(LAZYACCESS(params, RIGHT_CLICK))
			to_chat(mesmerized_target, "[src]'s eyes look into yours, and [span_hypnophrase("you forget what you're doing for a moment")]...")
			show_indicator_overlay(mesmerized_target)
			combat_mesmerize(mesmerized_target)
			PowerActivatedSuccesfully()
			return
	if(!do_after(user, mesmerize_delay, mesmerized_target, NONE, TRUE, extra_checks = CALLBACK(src, PROC_REF(ContinueActive), user, mesmerized_target)))
		return
	show_indicator_overlay(mesmerized_target)
	to_chat(mesmerized_target, "[src]'s eyes look into yours, and [span_hypnophrase("you feel your mind slipping away")]...")
	/*if(IS_MONSTERHUNTER(mesmerized_target))
		to_chat(mesmerized_target, span_notice("You feel your eyes burn for a while, but it passes."))
		return*/
	if(HAS_TRAIT_FROM_ONLY(mesmerized_target, TRAIT_NO_TRANSFORM, MESMERIZE_TRAIT))
		owner.balloon_alert(owner, "[mesmerized_target] is already in a hypnotic gaze.")
		return
	owner.balloon_alert(owner, "successfully mesmerized [mesmerized_target].")
	mesmerize_effects(user, mesmerized_target)
	PowerActivatedSuccesfully() // PAY COST! BEGIN COOLDOWN!

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/mesmerize_effects(mob/living/user, mob/living/mesmerized_target)
	var/power_time = get_power_time()
	mute_target(mesmerized_target, power_time)
	mesmerized_target.Immobilize(power_time)
	mesmerized_target.next_move = world.time + power_time // <--- Use direct change instead. We want an unmodified delay to their next move // mesmerized_target.changeNext_move(power_time) // check click.dm
	ADD_TRAIT(mesmerized_target, TRAIT_NO_TRANSFORM, MESMERIZE_TRAIT) // <--- Fuck it. We tried using next_move, but they could STILL resist. We're just doing a hard freeze.
	addtimer(CALLBACK(src, PROC_REF(end_mesmerize), user, mesmerized_target), power_time)

// TODO move some of these effects to only happen at higher level, and add victim/aggresor only eye effect
/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/combat_mesmerize(mob/living/user, mob/living/mesmerized_target)
	var/effect_time = combat_mesmerize_time()
	var/secondary_effect_time = combat_mesmerize_secondary_time()
	mesmerized_target.adjust_confusion(secondary_effect_time)
	mute_target(mesmerized_target, effect_time)
	mesmerized_target.Knockdown(effect_time)
	mesmerized_target.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/mesmerize_slowdown, TRUE, secondary_effect_time)
	addtimer(CALLBACK(src, PROC_REF(remove_slowdown), mesmerized_target), secondary_effect_time)
	PowerActivatedSuccesfully()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/get_power_time()
	return 9 SECONDS + level_current * 1.5 SECONDS

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/get_mute_time()
	return get_power_time() * 2

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/combat_mesmerize_time()
	var/power_time = get_power_time()
	power_time *= 0.3
	return power_time

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/combat_mesmerize_secondary_time()
	return combat_mesmerize_time() * 1.5

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/blind_target(mob/living/mesmerized_target)
	if(!blind_at_level && level_current < blind_at_level)
		return
	mesmerized_target.become_blind(MESMERIZE_TRAIT)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/mute_target(mob/living/mesmerized_target)
	if(level_current >= MESMERIZE_MUTE_LEVEL)
		mesmerized_target.adjust_silence(get_mute_time())

/datum/action/cooldown/bloodsucker/targeted/mesmerize/DeactivatePower()
	target_ref = null
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/remove_slowdown(mob/living/target)
	target.remove_movespeed_modifier(/datum/movespeed_modifier/mesmerize_slowdown)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/end_mesmerize(mob/living/user, mob/living/target)
	REMOVE_TRAIT(target, TRAIT_NO_TRANSFORM, MESMERIZE_TRAIT)
	target.cure_blind(MESMERIZE_TRAIT)
	// They Woke Up! (Notice if within view)
	if(istype(user) && target.stat == CONSCIOUS && (target in view(6, get_turf(user))))
		owner.balloon_alert(owner, "[target] snapped out of their trance.")

/datum/action/cooldown/bloodsucker/targeted/mesmerize/ContinueActive(mob/living/user, mob/living/target)
	return ..() && can_use(user) && CheckCanTarget(target)


/// Display an animated overlay over our head to indicate what's going on
/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/show_indicator_overlay(mob/target)
	if (!isnull(current_overlay))
		remove_image_from_clients(current_overlay, GLOB.clients)
	current_overlay = null
	current_overlay = image(icon = 'icons/effects/eldritch.dmi', loc = owner, icon_state = "eye_pulse", pixel_x = -owner.pixel_x, pixel_y = 28, layer = ABOVE_ALL_MOB_LAYER)
	SET_PLANE_EXPLICIT(current_overlay, ABOVE_LIGHTING_PLANE, owner)
	target.client.images += current_overlay

