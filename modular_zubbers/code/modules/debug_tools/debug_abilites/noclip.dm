/datum/action/cooldown/noclip
	name = "Toggle noclip"
	desc = "Grand you ability move through solid objects like turfs and mobs. This also renders you unclickable by other players."
	cooldown_time = 1 SECONDS

	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "the_freezer"
	var/enabled = FALSE

/datum/action/cooldown/noclip/IsAvailable(feedback)
	. = ..()

	if(owner.stat & DEAD)
		return
	if(INCAPACITATED_IGNORING(owner, INCAPABLE_GRAB))
		return

/datum/action/cooldown/noclip/Activate(atom/target)
	. = ..()
	if(enabled)
		disable_noclip()
		return TRUE
	enable_noclip()
	return TRUE

/datum/action/cooldown/noclip/proc/enable_noclip()
	owner.pass_flags |= PASSCLOSEDTURF | PASSTABLE | PASSDOORS | PASSBLOB | PASSGLASS | PASSGRILLE | PASSMOB | PASSSTRUCTURE | PASSVEHICLE
	owner.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	owner.density = FALSE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/noclip)
	owner.visible_message(span_notice("[owner.name], dissolves in air. Becoming non-physical."), span_notice("You going noclip."))
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(owner_dead), TRUE)
	enabled = TRUE

/datum/action/cooldown/noclip/proc/disable_noclip()
	owner.pass_flags = initial(owner.pass_flags)
	owner.mouse_opacity = initial(owner.mouse_opacity)
	owner.density = initial(owner.density)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/noclip)
	owner.visible_message(span_notice("[owner.name], becomes physical again."), span_notice("You back to normal again."))
	UnregisterSignal(owner, COMSIG_LIVING_DEATH)
	enabled = FALSE

/datum/action/cooldown/noclip/proc/owner_dead()
	SIGNAL_HANDLER

	if(enabled)
		disable_noclip()
		StartCooldown()

/datum/movespeed_modifier/noclip
	id = "noclip"
	movetypes = GROUND | FLYING
	multiplicative_slowdown = -2
