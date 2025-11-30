#define USE_SEEN_CLOAK_LEVEL 2
#define USE_RUN_CLOAK_LEVEL 4

/datum/action/cooldown/bloodsucker/cloak
	name = "Cloak of Darkness"
	desc = "Blend into the shadows and become invisible to the untrained and Artificial eye."
	button_icon_state = "power_cloak"
	power_explanation = "Cloak of Darkness:\n\
		Activate this Power in the shadows and you will slowly turn nearly invisible.\n\
		While using Cloak of Darkness, attempting to run will crush you.\n\
		Additionally, while Cloak is active, you are completely invisible to the AI.\n\
		Higher levels will increase how invisible you are.\n\
		At level 2, you will no longer need to be unseen to activate this power.\n\
		At level 4, you will be able to run while cloaked."
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 5
	constant_bloodcost = 0.2
	cooldown_time = 5 SECONDS
	var/was_running

/// Must have nobody around to see the cloak
/datum/action/cooldown/bloodsucker/cloak/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(level_current < USE_SEEN_CLOAK_LEVEL)
		for(var/mob/living/watcher in oviewers(9, owner))
			if(!watcher.mind)
				continue
			if(!can_see(watcher, owner))
				continue
			if(IS_BLOODSUCKER(watcher) || IS_GHOUL(watcher))
				continue
			owner.balloon_alert(owner, "you can only vanish unseen.")
			return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/cloak/ActivatePower(atom/target)
	var/mob/living/user = owner
	was_running = (user.move_intent == MOVE_INTENT_RUN)
	if(level_current < USE_RUN_CLOAK_LEVEL && was_running)
		user.toggle_move_intent()
	user.AddElement(/datum/element/digitalcamo)
	user.balloon_alert(user, "cloak turned on.")
	return TRUE

/datum/action/cooldown/bloodsucker/cloak/process(seconds_per_tick)
	// Checks that we can keep using this.
	. = ..()
	if(!.)
		return
	if(!active)
		return
	var/mob/living/user = owner
	animate(user, alpha = max(25, owner.alpha - min(75, 10 + 5 * level_current)), time = 1.5 SECONDS)
	// Prevents running while on Cloak of Darkness
	if(level_current < USE_RUN_CLOAK_LEVEL && user.move_intent != MOVE_INTENT_WALK)
		owner.balloon_alert(owner, "you attempt to run, crushing yourself.")
		user.toggle_move_intent()
		user.adjust_brute_loss(rand(5, 15))

/datum/action/cooldown/bloodsucker/cloak/ContinueActive(mob/living/user, mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	/// Must be CONSCIOUS
	if(user.stat != CONSCIOUS)
		to_chat(owner, span_warning("Your cloak failed due to you falling unconcious!"))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/cloak/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/user = owner
	animate(user, alpha = 255, time = 1 SECONDS)
	user.RemoveElement(/datum/element/digitalcamo)
	if(level_current < USE_RUN_CLOAK_LEVEL && was_running && user.move_intent == MOVE_INTENT_WALK)
		user.toggle_move_intent()
	user.balloon_alert(user, "cloak turned off.")

#undef USE_SEEN_CLOAK_LEVEL
#undef USE_RUN_CLOAK_LEVEL
