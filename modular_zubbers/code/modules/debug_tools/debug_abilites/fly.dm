/datum/action/cooldown/fly
	name = "Toggle fly"
	desc = "Grand you ability to move freely and cross the space."

	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "lintel"
	var/enabled = FALSE


/datum/action/cooldown/fly/IsAvailable(feedback)
	. = ..()

	if(owner.stat & DEAD)
		return

/datum/action/cooldown/fly/Activate(atom/target)
	. = ..()
	if(enabled)
		disable_fly()
		return TRUE
	enable_fly()
	return TRUE

/datum/action/cooldown/fly/proc/enable_fly()
	owner.movement_type = FLYING
	owner.plane += 2
	enabled = TRUE
	owner.visible_message(span_notice("[owner.name], takes off over the ground."), span_notice("You going fly."))
	playsound(owner, 'sound/effects/gravhit.ogg', 25)
	ADD_TRAIT(owner, TRAIT_FORCED_GRAVITY, REF(src))
	animate(owner, 5 SECONDS, alpha = 100)
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(owner_dead), TRUE)
	DO_FLOATING_ANIM(owner)

/datum/action/cooldown/fly/proc/disable_fly()
	owner.movement_type = initial(owner.movement_type)
	owner.plane = initial(owner.plane)
	enabled = FALSE
	owner.visible_message(span_notice("[owner.name], has landed on the ground."), span_notice("You land on the ground."))
	playsound(owner, 'sound/effects/gravhit.ogg', 25)
	REMOVE_TRAIT(owner, TRAIT_FORCED_GRAVITY, REF(src))
	owner.alpha = initial(owner.alpha)
	UnregisterSignal(owner, COMSIG_LIVING_DEATH)
	STOP_FLOATING_ANIM(owner)

/datum/action/cooldown/fly/proc/owner_dead()
	SIGNAL_HANDLER

	if(enabled)
		disable_fly()
