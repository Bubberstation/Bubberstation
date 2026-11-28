/datum/action/cooldown/vampire/astral_projection
	name = "Astral Projection"
	desc = "The power of your blood empowers your auspex. Become able to project your consciousness outside your body."
	power_explanation = "When Activated, you will become a ghost.\n\
		Your body lies in Torpor until you return to it, and the cooldown starts once you do.\n\
		If your body is hurt while you are away, you are wrenched back into it.\n\
		Visit anywhere you like, watch anyone you want.\n\
		Talk to the spriits, and know all things."
	active_background_icon_state = "tremere_power_gold_on"
	base_background_icon_state = "tremere_power_gold_off"
	button_icon_state = "power_astral_projection"
	vampire_power_flags = BP_AM_TOGGLE
	vitaecost = 200
	cooldown_time = 60 SECONDS
	var/mob/living/awaiting_return

/datum/action/cooldown/vampire/astral_projection/activate_power()
	. = ..()
	owner.playsound_local(null, 'modular_zubbers/sound/effects/vampires/auspex.ogg', 50, TRUE, pressure_affected = FALSE)
	var/mob/living/body = owner
	var/mob/dead/observer/ghost = body.ghostize(can_reenter_corpse = TRUE)
	if(ghost)
		var/datum/status_effect/vampire_torpor/torpor = body.apply_status_effect(/datum/status_effect/vampire_torpor)
		torpor?.hold_until_login()
		if(!awaiting_return)
			awaiting_return = body
			RegisterSignal(body, COMSIG_MOB_LOGIN, PROC_REF(on_return))
		ADD_TRAIT(ghost, TRAIT_NO_OBSERVE, TRAIT_VAMPIRE)
		ghost.add_atom_colour(COLOR_VOID_PURPLE, ADMIN_COLOUR_PRIORITY)
		var/ghost_name = "Astral Shade of [ghost.name]"
		ghost.name = ghost_name
		ghost.deadchat_name = ghost_name
		ghost.add_filter("astral_projection", 1, outline_filter(size = 1, color = BLOOD_COLOR_RED))
	deactivate_power()

/datum/action/cooldown/vampire/astral_projection/proc/on_return(mob/living/source)
	SIGNAL_HANDLER
	stop_awaiting_return()
	StartCooldown()

/datum/action/cooldown/vampire/astral_projection/proc/stop_awaiting_return()
	if(!awaiting_return)
		return
	UnregisterSignal(awaiting_return, COMSIG_MOB_LOGIN)
	awaiting_return = null

/datum/action/cooldown/vampire/astral_projection/Remove(mob/removed_from)
	stop_awaiting_return()
	return ..()
