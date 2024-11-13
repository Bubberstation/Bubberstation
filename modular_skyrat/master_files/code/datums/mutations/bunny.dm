/datum/mutation/human/strong_legs
	name = "Strong Legs"
	desc = "Strengtens the calves of the subject, allowing them to leap across gaps."
	quality = POSITIVE
	difficulty = 12
	text_gain_indication = span_notice("Your leg muscles feel stronger.")
	text_lose_indication = span_notice("Your leg muscles are weakening.")
	power_path = /datum/action/cooldown/mob_cooldown/leap
	instability = 25

/datum/mutation/human/strong_legs/modify()
	. = ..()
	var/datum/action/cooldown/mob_cooldown/leap/ability = .
	if(!istype(ability)) // null or invalid
		return

	if(GET_MUTATION_POWER(src) <= 1) // we only care about power from here on
		ability.leap_strength = initial(ability.leap_strength)
		return

	ability.leap_strength += 1

#define LEAP_TIME_MODIFIER 0.5 SECONDS

/datum/action/cooldown/mob_cooldown/leap
	name = "Leap"
	desc = "You propel yourself into the air, allowing you to cross short gaps."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "lace"
	cooldown_time = 10 SECONDS
	click_to_activate = FALSE

	///Strength of the leap, extends the height and length of the jump
	var/leap_strength = 1

/datum/action/cooldown/mob_cooldown/leap/IsAvailable(feedback)
	. = ..()
	if(!.)
		return
	if(!iscarbon(owner))
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/leap/Activate(atom/target)
	var/mob/living/carbon/bunny = owner // We already know they're a carbon, see IsAvailable()
	var/leap_height = 16 * leap_strength
	var/leap_length = leap_strength * LEAP_TIME_MODIFIER
	bunny.apply_status_effect(/datum/status_effect/bunny_hop, leap_length)
	// Fast way up, slow way down
	animate(bunny, pixel_y = leap_height, time = leap_length/3)
	animate(pixel_y = 0, time = (2 * leap_length)/3)
	StartCooldown()

/datum/status_effect/bunny_hop
	id = "bigleap"

	duration = LEAP_TIME_MODIFIER
	tick_interval = 0.2 SECONDS

	alert_type = null

/datum/status_effect/bunny_hop/on_creation(mob/living/new_owner, duration = LEAP_TIME_MODIFIER, ...)
	src.duration = duration
	. = ..()

/datum/status_effect/bunny_hop/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	ADD_TRAIT(owner, TRAIT_MOVE_FLYING, type)
	return TRUE

/datum/status_effect/bunny_hop/Destroy()
	UnregisterSignal(owner, COMSIG_MOVABLE_BUMP)
	REMOVE_TRAIT(owner, TRAIT_MOVE_FLYING, type)
	. = ..()

/datum/status_effect/bunny_hop/proc/on_bump(mob/living/carbon/source, atom/bumped_atom)
	SIGNAL_HANDLER
	if(!istype(source))
		return
	if(!istype(bumped_atom, /obj/structure/window))
		return
	var/obj/structure/window/bumped_window = bumped_atom
	if(!bumped_window.reinf)
		source.forceMove(get_turf(bumped_window))
		bumped_window.deconstruct(disassembled = FALSE)
		source.apply_damage(damage = 5, damagetype = BRUTE)
		source.visible_message(span_warning("[source] slams [source.p_their()] body through the window!"))
	else
		source.adjustStaminaLoss(20, forced = TRUE)
		source.Paralyze(0.5 SECONDS, ignore_canstun = FALSE)
		source.apply_damage(damage = 5, damagetype = BRUTE, def_zone = BODY_ZONE_HEAD)
		var/harsh_crash = FALSE
		if(prob(10)) // 10 percent for unforseen consequences
			harsh_crash = TRUE
			var/obj/item/bodypart/affecting = source.get_bodypart(BODY_ZONE_HEAD)
			affecting.force_wound_upwards(/datum/wound/blunt/bone/severe)
		source.visible_message(span_warning("[source] smacks [source.p_their()] head against the window[harsh_crash ? " and cracks their skull open" : ""]! Ouch."))

#undef LEAP_TIME_MODIFIER

/obj/item/dnainjector/strong_legs
	name = "\improper DNA injector (Strong Legs)"
	desc = "Makes you leap like a bunny."
	add_mutations = list(/datum/mutation/human/strong_legs)
