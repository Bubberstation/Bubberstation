#define CELERITY_FX_LEVEL 3
#define CELERITY_DODGE_LEVEL 6
#define CELERITY_BLUR "celerity_blur"

/datum/action/cooldown/bloodsucker/celerity
	name = "Celerity"
	desc = "Grant yourself supernatural speed and reflexes."
	button_icon_state = "power_speed"
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 10
	constant_bloodcost = 3
	cooldown_time = 20 SECONDS
	var/celerity_speed
	var/celerity_delay

/datum/action/cooldown/bloodsucker/celerity/get_power_explanation_extended()
	. = list()
	. += "Utilize your blood to increase your speed and reflexes."
	. += "This will drain blood at a constant rate of one unit per second while active."
	. += "You'll be able to move faster and attack faster, scaling with level."
	. += "At level [CELERITY_FX_LEVEL], you'll move fast enough that you can no longer conceal your Celerity."
	. += "At level [CELERITY_DODGE_LEVEL], you'll be able to dodge projectiles for the first few seconds of your Celerity."

/datum/action/cooldown/bloodsucker/celerity/ActivatePower(atom/target)
	var/mob/living/user = owner
	var/datum/movespeed_modifier/celerity_mod = new()
	celerity_speed = GetCeleritySpeed()
	celerity_delay = GetCelerityDelay()
	celerity_mod.multiplicative_slowdown = celerity_speed //lightpink extract at level 10, just without the pacifism
	owner.add_movespeed_modifier(celerity_mod, update = TRUE)
	owner.next_move_modifier *= celerity_delay
	if(level_current >= CELERITY_FX_LEVEL)
		RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	if(level_current >= CELERITY_DODGE_LEVEL)
		user.apply_status_effect(/datum/status_effect/rapid_reflexes)
		to_chat(owner, span_notice("Our reflexes hone themselves."))

	user.balloon_alert(user, "the world slows down.")
	return TRUE

/datum/action/cooldown/bloodsucker/celerity/process(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/mob/living/user = owner
	user.adjustStaminaLoss(-6 * level_current * REM * seconds_per_tick)

/datum/action/cooldown/bloodsucker/celerity/proc/on_movement(mob/living/carbon/user, atom/old_loc)
	SIGNAL_HANDLER
	new /obj/effect/temp_visual/decoy/celerity(old_loc, user)

/obj/effect/temp_visual/decoy/celerity
	duration = 0.25 SECONDS
	/// The color matrix it should be at spawn
	var/list/matrix_start = list(1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0.5,0,0,0)
	/// The color matrix it should be by the time it despawns
	var/list/matrix_end = list(1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0.2,0,0,0)

/obj/effect/temp_visual/decoy/celerity/Initialize(mapload)
	. = ..()
	color = matrix_start
	animate(src, color = matrix_end, time = duration, easing = EASE_OUT)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)

/datum/status_effect/rapid_reflexes
	id = "Rapid Reflexes"
	status_type = STATUS_EFFECT_REFRESH
	duration = 3 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/rapid_reflexes
	tick_interval = 0.2 SECONDS
	show_duration = TRUE

/datum/status_effect/rapid_reflexes/on_apply()
	RegisterSignal(owner, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(dodge_bullets))
	owner.add_atom_colour("#d30d0d", TEMPORARY_COLOUR_PRIORITY)
	owner.add_filter(id, 2, list("type" = "outline", "color" = "#d30d0d", "size" = 1))
	var/filter = owner.get_filter(id)
	animate(filter, alpha = 127, time = 1 SECONDS, loop = -1)
	animate(alpha = 63, time = 2 SECONDS)
	return TRUE

/datum/status_effect/rapid_reflexes/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_PRE_BULLET_ACT)
	owner.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, "#d30d0d")
	owner.remove_filter(id)

/datum/status_effect/rapid_reflexes/proc/dodge_bullets(mob/living/carbon/human/source, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	if(HAS_TRAIT(source, TRAIT_INCAPACITATED))
		return NONE
	source.visible_message(
		span_danger("[source] effortlessly dodges [hitting_projectile]!"),
		span_userdanger("You effortlessly evade [hitting_projectile]!"),
	)
	playsound(source, pick('sound/items/weapons/bulletflyby.ogg', 'sound/items/weapons/bulletflyby2.ogg', 'sound/items/weapons/bulletflyby3.ogg'), 75, TRUE)
	source.add_filter(CELERITY_BLUR, 2, motion_blur_filter(2, 2))
	addtimer(CALLBACK(source, TYPE_PROC_REF(/datum, remove_filter), CELERITY_BLUR), 0.5 SECONDS)
	return COMPONENT_BULLET_PIERCED

/atom/movable/screen/alert/status_effect/rapid_reflexes
	name = "Rapid Reflexes"
	desc = "Your reflexes are inhuman, enough to dodge bullets."
	icon_state = "rapid_reflexes"

/datum/action/cooldown/bloodsucker/celerity/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/user = owner
	var/datum/movespeed_modifier/celerity_mod = new()
	celerity_speed = GetCeleritySpeed()
	celerity_delay = GetCelerityDelay()
	celerity_mod.multiplicative_slowdown = celerity_speed
	owner.remove_movespeed_modifier(celerity_mod, update = TRUE)
	owner.next_move_modifier /= celerity_delay
	if(level_current >= CELERITY_FX_LEVEL)
		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	user.balloon_alert(user, "the world speeds up.")
	return TRUE

/datum/action/cooldown/bloodsucker/celerity/proc/GetCeleritySpeed()
	return -0.05 * level_current

/datum/action/cooldown/bloodsucker/celerity/proc/GetCelerityDelay()
	return min(0.025 * level_current, 0.5)

#undef CELERITY_FX_LEVEL
#undef CELERITY_DODGE_LEVEL
#undef CELERITY_BLUR
