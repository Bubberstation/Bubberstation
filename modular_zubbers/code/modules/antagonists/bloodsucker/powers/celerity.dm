
/datum/action/cooldown/bloodsucker/celerity
	name = "Celerity"
	desc = "Grant yourself supernatural speed and reflexes."
	button_icon_state = "power_speed"
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 10
	constant_bloodcost = 1
	cooldown_time = 20 SECONDS

/datum/action/cooldown/bloodsucker/celerity/get_power_explanation_extended()
	. = list()
	. += "Utilize your blood to increase your speed and reflexes."
	. += "This will drain blood at a constant rate of one unit per second while active."
	. += "You'll be able to move faster and shoot faster, scaling with level."

/datum/action/cooldown/bloodsucker/celerity/ActivatePower(atom/target)
	var/mob/living/user = owner
	var/datum/movespeed_modifier/celerity_mod = new()
	celerity_mod.multiplicative_slowdown = -0.05*level_current //lightpink extract at level 10, just without the pacifism
	owner.add_movespeed_modifier(celerity_mod, update = TRUE)
	owner.next_move_modifier *= min(0.05*level_current, 0.5)
	if(level_current > 3)
		RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	user.balloon_alert(user, "the world slows down.")
	return TRUE

/datum/action/cooldown/bloodsucker/celerity/process(seconds_per_tick)
	// Checks that we can keep using this.
	. = ..()
	if(!.)
		return
	if(!active)
		return
	var/mob/living/user = owner
	user.adjustStaminaLoss(-3 * level_current * REM * seconds_per_tick)

/datum/action/cooldown/bloodsucker/celerity/proc/on_movement(mob/living/carbon/user, atom/old_loc)
	SIGNAL_HANDLER
	new /obj/effect/temp_visual/decoy/celerity(old_loc, user)

/obj/effect/temp_visual/decoy/celerity
	duration = 0.75 SECONDS
	/// The color matrix it should be at spawn
	var/list/matrix_start = list(1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0.5,0,0,0)
	/// The color matrix it should be by the time it despawns
	var/list/matrix_end = list(1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0.2,0,0,0)

/obj/effect/temp_visual/decoy/celerity/Initialize(mapload)
	. = ..()
	color = matrix_start
	animate(src, color = matrix_end, time = duration, easing = EASE_OUT)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)

/datum/action/cooldown/bloodsucker/celerity/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/user = owner
	var/datum/movespeed_modifier/celerity_mod = new()
	celerity_mod.multiplicative_slowdown = -0.05*level_current
	owner.remove_movespeed_modifier(celerity_mod, update = TRUE)
	owner.next_move_modifier /= min(0.05*level_current, 0.5)
	if(level_current > 3)
		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	user.balloon_alert(user, "the world speeds up.")
	return TRUE
