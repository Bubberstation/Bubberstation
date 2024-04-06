/**
 *	MEZMERIZE
 *	 Locks a target in place for a certain amount of time.
 *
 * 	Level 2: Additionally mutes
 * 	Level 3: Can be used through face protection
 * 	Level 5: Doesn't need to be facing you anymore
 */

/datum/action/cooldown/bloodsucker/targeted/mesmerize
	name = "Mesmerize"
	desc = "Dominate the mind of a mortal who can see your eyes."
	button_icon_state = "power_mez"
	power_explanation = "Mesmerize:\n\
		Click any player to attempt to mesmerize them.\n\
		You cannot wear anything covering your face, and both parties must be facing eachother. Obviously, both parties need to not be blind. \n\
		Right clicking with the ability will apply a knockdown, but will also confuse your victim.\n\
		If your target is already mesmerized or a Monster Hunter, the Power will fail.\n\
		Once mesmerized, the target will be unable to move for a certain amount of time, scaling with level.\n\
		At level 2, your target will additionally be muted.\n\
		At level 3, you will be able to use the power through items covering your face.\n\
		At level 5, you will be able to mesmerize regardless of your target's direction.\n\
		Higher levels will increase the time of the mesmerize's freeze.\n\
		Additionally it works on silicon lifeforms, causing a EMP effect instead of a freeze."
	power_flags = NONE
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|BP_CANT_USE_WHILE_INCAPACITATED|BP_CANT_USE_WHILE_UNCONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|VASSAL_CAN_BUY
	bloodcost = 30
	cooldown_time = 20 SECONDS
	target_range = 8
	power_activates_immediately = FALSE
	prefire_message = "Whom will you subvert to your will?"
	///Our mesmerized target - Prevents several mesmerizes.
	var/datum/weakref/target_ref
	/// How long it takes us to mesmerize our target.
	var/mesmerize_delay = 4 SECONDS
	/// At what level this ability will blind the target at. Level 0 = never.
	var/blind_at_level = 0
	var/requires_facing_target = TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.) // Default checks
		return FALSE
	if(!user.get_organ_slot(ORGAN_SLOT_EYES))
		// Cant use balloon alert, they've got no eyes!
		to_chat(user, span_warning("You have no eyes with which to mesmerize."))
		return FALSE
	// Check: Eyes covered?
	if(istype(user) && (user.is_eyes_covered() && level_current <= 2) || !isturf(user.loc))
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
	. = ..()

	var/mob/living/user = owner
	var/mob/living/carbon/mesmerized_target = target_ref.resolve()

	if(issilicon(mesmerized_target))
		var/mob/living/silicon/mesmerized = mesmerized_target
		mesmerized.emp_act(EMP_HEAVY)
		owner.balloon_alert(owner, "temporarily shut [mesmerized] down.")
		PowerActivatedSuccesfully() // PAY COST! BEGIN COOLDOWN!
		return
	var/power_time = 9 SECONDS + level_current * 1.5 SECONDS
	if(istype(mesmerized_target))
		owner.balloon_alert(owner, "attempting to hypnotically gaze [mesmerized_target]...")
		if(LAZYACCESS(params, RIGHT_CLICK))
			to_chat(mesmerized_target, "[src]'s eyes look into yours, and [span_hypnophrase("you forget what you're doing for a moment")]...")
			combat_mesmerize(mesmerized_target, power_time)
			PowerActivatedSuccesfully()
			return
	if(!do_after(user, mesmerize_delay, mesmerized_target, NONE, TRUE, extra_checks = CALLBACK(src, PROC_REF(ContinueActive), user, mesmerized_target)))
		return
	to_chat(mesmerized_target, "[src]'s eyes look into yours, and [span_hypnophrase("you feel your mind slipping away")]...")
	/*if(IS_MONSTERHUNTER(mesmerized_target))
		to_chat(mesmerized_target, span_notice("You feel your eyes burn for a while, but it passes."))
		return*/
	if(HAS_TRAIT_FROM_ONLY(mesmerized_target, TRAIT_NO_TRANSFORM, BLOODSUCKER_TRAIT))
		owner.balloon_alert(owner, "[mesmerized_target] is already in a hypnotic gaze.")
		return
	if(iscarbon(mesmerized_target))
		owner.balloon_alert(owner, "successfully mesmerized [mesmerized_target].")
		mesmerize_effects(user, mesmerized_target, power_time)
	PowerActivatedSuccesfully() // PAY COST! BEGIN COOLDOWN!

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/mesmerize_effects(mob/living/user, mob/living/mesmerized_target, power_time)
	mute_target(mesmerized_target, power_time)
	mesmerized_target.Immobilize(power_time)
	mesmerized_target.next_move = world.time + power_time // <--- Use direct change instead. We want an unmodified delay to their next move // mesmerized_target.changeNext_move(power_time) // check click.dm
	ADD_TRAIT(mesmerized_target, TRAIT_NO_TRANSFORM, BLOODSUCKER_TRAIT) // <--- Fuck it. We tried using next_move, but they could STILL resist. We're just doing a hard freeze.
	addtimer(CALLBACK(src, PROC_REF(end_mesmerize), user, mesmerized_target), power_time)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/combat_mesmerize(mob/living/mesmerized_target, power_time)
	power_time *= 0.3
	mesmerized_target.adjust_confusion(power_time * 1.5)
	mute_target(mesmerized_target, power_time)
	mesmerized_target.Knockdown(power_time)
	mesmerized_target.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/mesmerize_slowdown, TRUE, level_current * 0.5)
	addtimer(CALLBACK(src, PROC_REF(remove_slowdown), mesmerized_target), power_time * 1.5)
	PowerActivatedSuccesfully()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/blind_target(mob/living/mesmerized_target)
	if(!blind_at_level && level_current < blind_at_level)
		return
	mesmerized_target.become_blind(BLOODSUCKER_TRAIT)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/mute_target(mob/living/mesmerized_target, power_time)
	if(level_current >= 2)
		mesmerized_target.adjust_silence(power_time * 2)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/DeactivatePower()
	target_ref = null
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/remove_slowdown(mob/living/target)
	target.remove_movespeed_modifier(/datum/movespeed_modifier/mesmerize_slowdown)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/proc/end_mesmerize(mob/living/user, mob/living/target)
	REMOVE_TRAIT(target, TRAIT_NO_TRANSFORM, BLOODSUCKER_TRAIT)
	target.cure_blind(BLOODSUCKER_TRAIT)
	// They Woke Up! (Notice if within view)
	if(istype(user) && target.stat == CONSCIOUS && (target in view(6, get_turf(user))))
		owner.balloon_alert(owner, "[target] snapped out of their trance.")

/datum/action/cooldown/bloodsucker/targeted/mesmerize/ContinueActive(mob/living/user, mob/living/target)
	return ..() && can_use(user) && CheckCanTarget(target)
