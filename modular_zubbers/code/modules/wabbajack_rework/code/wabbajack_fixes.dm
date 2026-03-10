
//Signal for when we're restored
/datum/status_effect/shapechange_mob/restore_caster(kill_caster_after = FALSE)
	. = ..()
	SEND_SIGNAL(owner, COMSIG_LIVING_WABBAJACK_RESTORE, caster_mob)



//Wabbajack AI Shell Fix
/mob/living/silicon/robot/proc/pre_wabbajack()

	SIGNAL_HANDLER

	if(shell)
		if(mainframe && mainframe.deployed_shell == src)
			mainframe.disconnect_shell()
		GLOB.available_ai_shells -= src

/mob/living/silicon/robot/proc/post_wabbajack()

	SIGNAL_HANDLER

	if(shell)
		GLOB.available_ai_shells |= src

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	RegisterSignal(src,COMSIG_LIVING_PRE_WABBAJACKED,PROC_REF(pre_wabbajack))
	RegisterSignal(src,COMSIG_LIVING_WABBAJACK_RESTORE,PROC_REF(post_wabbajack))


//Wabbajack AI Core Fix
/mob/living/silicon/ai/proc/pre_wabbajack()

	SIGNAL_HANDLER

	src.disconnect_shell() //Kick us out of our currently controlled shell.

/mob/living/silicon/ai/Initialize(mapload)
	. = ..()
	RegisterSignal(src,COMSIG_LIVING_PRE_WABBAJACKED,PROC_REF(pre_wabbajack))
