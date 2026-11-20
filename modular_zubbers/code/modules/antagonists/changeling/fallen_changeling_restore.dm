// yes, a lot of this code is copied from changelings.
// no, it should not be a child type of changeling code -- changeling code is meant for changelings, not fallen, who it won't work on
/datum/action/changeling_restore_fallen
	name = "Absorb DNA (Restorative)"
	desc = "Absorb the DNA of our victim, restoring our powers. Requires us to strangle them."
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "absorb_dna"
	var/is_absorbing = FALSE
	var/datum/looping_sound/changeling_absorb/absorbing_loop

/datum/action/changeling_restore_fallen/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/mob/user = owner
	if(!user || !user?.mind?.has_antag_datum(/datum/antagonist/fallen_changeling))
		return
	try_to_sting(user)

/datum/action/changeling_restore_fallen/proc/try_to_sting(mob/living/user, mob/living/target)
	if(!can_sting(user, target))
		return FALSE
	if(user.fire_stacks && user.on_fire)
		user.balloon_alert(user, "on fire!")
		return FALSE
	if(sting_action(user, target))
		user.changeNext_move(CLICK_CD_MELEE)
		return TRUE
	return FALSE

/datum/action/changeling_restore_fallen/proc/can_sting(mob/living/carbon/owner)
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
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
	return can_absorb_dna(target)

/datum/action/changeling_restore_fallen/proc/attempt_absorb(mob/living/carbon/human/target)
	for(var/absorbing_iteration in 1 to 3)
		switch(absorbing_iteration)
			if(1)
				to_chat(owner, span_notice("This creature is compatible. We must hold still..."))
			if(2)
				owner.visible_message(span_warning("[owner] extends a proboscis!"), span_notice("We extend a proboscis."))
			if(3)
				absorbing_loop = new(owner, start_immediately = TRUE)
				owner.visible_message(span_danger("[owner] stabs [target] with the proboscis!"), span_notice("We stab [target] with the proboscis."))
				to_chat(target, span_userdanger("You feel a sharp stabbing pain!"))
				target.take_overall_damage(40)

		SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("Absorb DNA", "[absorbing_iteration]"))
		if(!do_after(owner, 15 SECONDS, target, cog_icon = null))
			owner.balloon_alert(owner, "interrupted!")
			qdel(absorbing_loop)
			is_absorbing = FALSE
			return FALSE

	var/datum/antagonist/changeling/is_fallen_changeling = owner?.mind?.has_antag_datum(/datum/antagonist/fallen_changeling)
	if(is_fallen_changeling)
		to_chat(owner, span_boldnotice("We have integrated [target]'s genes into ours, making us whole once more."))

		var/list/copied_objectives = is_fallen_changeling.objectives.Copy()
		owner.mind.remove_antag_datum(/datum/antagonist/fallen_changeling)
		var/datum/antagonist/changeling/newling = owner.mind.add_antag_datum(/datum/antagonist/changeling)
		newling.objectives = copied_objectives
		newling.absorbed_count += 1

/datum/action/changeling_restore_fallen/proc/sting_action(mob/owner)
	SHOULD_CALL_PARENT(0)
	var/mob/living/carbon/human/target = owner.pulling
	is_absorbing = TRUE
	if(!attempt_absorb(target))
		is_absorbing = FALSE
		return FALSE
	qdel(absorbing_loop)
	is_absorbing = FALSE
	return TRUE

/datum/action/changeling_restore_fallen/proc/can_absorb_dna(mob/living/carbon/human/target, verbose = TRUE)
	if(!target)
		return FALSE
	if(!iscarbon(owner))
		return FALSE
	var/mob/living/carbon/user = owner

	if(!target.has_dna() || HAS_TRAIT(target, TRAIT_NO_DNA_COPY))
		if(verbose)
			to_chat(user, span_warning("[target] is not compatible with our biology."))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_BADDNA) || HAS_TRAIT(target, TRAIT_HUSK))
		if(verbose)
			to_chat(user, span_warning("[target]'s DNA is ruined beyond usability!"))
		return FALSE
	if(!ishuman(target) || ismonkey(target) || isnull(target?.mind?.key))//Absorbing monkeys is entirely possible, but it can cause issues with transforming. That's what lesser form is for anyway!
		if(verbose)
			to_chat(user, span_warning("We could gain no benefit from absorbing a lesser creature."))
		return FALSE

	return TRUE
///////////////// fallen ling overrides /////////////////

/datum/antagonist/fallen_changeling/
	//grants reabsorption ability
	var/datum/action/changeling_restore_fallen/fallen_suck_action

/datum/antagonist/fallen_changeling/Destroy()
	. = ..()
	QDEL_NULL(fallen_suck_action)

/datum/antagonist/fallen_changeling/on_gain()
	. = ..()
	fallen_suck_action = new()
	fallen_suck_action.Grant(owner.current)
