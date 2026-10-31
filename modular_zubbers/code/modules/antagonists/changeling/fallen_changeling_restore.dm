/datum/action/changeling/absorb_dna/fallen
	name = "Absorb DNA (Restorative)"
	desc = "Absorb the DNA of our victim, restoring our powers. Requires us to strangle them."
	button_icon_state = "absorb_dna"
	dna_cost = CHANGELING_POWER_UNOBTAINABLE //invalid to buy from cellular emporium

/datum/action/changeling/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(. == FALSE) //changeling antag status has no bearing on whether parent returns false or true -- ergo this is true if action is usable under non-changeling conditions
		return
	try_to_sting(owner)

/datum/action/changeling/absorb_dna/fallen/can_sting(mob/living/carbon/owner)
	if(req_stat < IS_UNCONSCIOUS_OR_CRIT(owner) || (req_stat == STABLE && IS_UNCONSCIOUS(owner)))
		owner.balloon_alert(owner, "incapacitated!")
		return FALSE

	if(is_absorbing)
		owner.balloon_alert(owner, "already absorbing!")
		return FALSE

	if(!owner.pulling || !iscarbon(owner.pulling))
		owner.balloon_alert(owner, "needs grab!")
		return FALSE

	if(owner.grab_state <= GRAB_NECK)
		owner.balloon_alert(owner, "needs tighter grip!")
		return FALSE

	var/mob/living/carbon/target = owner.pulling
	var/datum/antagonist/fallen_changeling/fallen = owner?.mind?.has_antag_datum(/datum/antagonist/fallen_changeling)
	return fallen.can_absorb_dna(target)

/datum/action/changeling/absorb_dna/fallen/attempt_absorb(mob/living/carbon/human/target)
	. = ..(target)
	if(.)
		var/datum/antagonist/changeling/is_fallen_changeling = owner?.mind?.has_antag_datum(/datum/antagonist/fallen_changeling)
		if(is_fallen_changeling)
			to_chat(owner, span_boldnotice("We have integrated [target]'s genes into ours, making us whole once more."))

			var/list/copied_objectives = is_fallen_changeling.objectives.Copy()
			owner.mind.remove_antag_datum(/datum/antagonist/fallen_changeling)
			var/datum/antagonist/changeling/newling = owner.mind.add_antag_datum(/datum/antagonist/changeling)
			newling.objectives = copied_objectives
			newling.absorbed_count += 1

/datum/action/changeling/absorb_dna/fallen/sting_action(mob/owner)
	SHOULD_CALL_PARENT(0)
	var/mob/living/carbon/human/target = owner.pulling
	is_absorbing = TRUE
	if(!attempt_absorb(target))
		is_absorbing = FALSE
		return FALSE
	qdel(absorbing_loop)
	is_absorbing = FALSE
	return TRUE

/datum/action/changeling/absorb_dna/fallen/try_to_sting(mob/living/user, mob/living/target)
	if(!can_sting(user, target))
		return FALSE
	if(disabled_by_fire && user.fire_stacks && user.on_fire)
		user.balloon_alert(user, "on fire!")
		return FALSE
	if(sting_action(user, target))
		sting_feedback(user, target)
		user.changeNext_move(CLICK_CD_MELEE)
		return TRUE
	return FALSE
///////////////// fallen ling overrides /////////////////

/*
 * Checks if this changeling can absorb the DNA of [target].
 * if [verbose] = TRUE, give feedback as to why they cannot absorb the DNA.
 */
/datum/antagonist/fallen_changeling/proc/can_absorb_dna(mob/living/carbon/human/target, verbose = TRUE)
	if(!target)
		return FALSE
	if(!iscarbon(owner.current))
		return FALSE
	var/mob/living/carbon/user = owner.current

	if(!target.has_dna() || HAS_TRAIT(target, TRAIT_NO_DNA_COPY))
		if(verbose)
			to_chat(user, span_warning("[target] is not compatible with our biology."))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_BADDNA) || HAS_TRAIT(target, TRAIT_HUSK))
		if(verbose)
			to_chat(user, span_warning("[target]'s DNA is ruined beyond usability!"))
		return FALSE
	if(!ishuman(target) || ismonkey(target) || !isnull(target?.mind?.key))//Absorbing monkeys is entirely possible, but it can cause issues with transforming. That's what lesser form is for anyway!
		if(verbose)
			to_chat(user, span_warning("We could gain no benefit from absorbing a lesser creature."))
		return FALSE

	return TRUE

/datum/antagonist/fallen_changeling/
	//grants reabsorption ability
	var/datum/action/changeling/absorb_dna/fallen/fallen_suck_action

/datum/antagonist/fallen_changeling/Destroy()
	. = ..()
	QDEL_NULL(fallen_suck_action)

/datum/antagonist/fallen_changeling/on_gain()
	. = ..()
	fallen_suck_action = new()
	fallen_suck_action.Grant(owner.current)
