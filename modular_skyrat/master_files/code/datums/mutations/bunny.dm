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
	var/leap_duration = leap_strength * 0.5 SECONDS

	// Sets up our signals and callback
	RegisterSignal(bunny, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	ADD_TRAIT(bunny, TRAIT_MOVE_FLYING, type)
	addtimer(CALLBACK(src, PROC_REF(clear_effects), bunny), leap_duration)

	// Fast way up, slow way down
	animate(bunny, pixel_y = leap_height, time = leap_duration/2, easing = CIRCULAR_EASING | EASE_OUT)
	animate(pixel_y = 0, time = leap_duration/2, easing = CIRCULAR_EASING | EASE_IN)
	StartCooldown()

/datum/action/cooldown/mob_cooldown/leap/proc/clear_effects(mob/living/carbon/bunny)
	UnregisterSignal(bunny, COMSIG_MOVABLE_BUMP)
	REMOVE_TRAIT(bunny, TRAIT_MOVE_FLYING, type)

/datum/action/cooldown/mob_cooldown/leap/proc/on_bump(mob/living/carbon/source, atom/bumped_atom)
	SIGNAL_HANDLER
	if(!istype(source))
		return
	if(istype(bumped_atom, /obj/structure/window))
		on_window_bump(source, bumped_atom)
		return
	if(istype(bumped_atom, /obj/structure/grille))
		on_grille_bump(source, bumped_atom)
		return

/datum/action/cooldown/mob_cooldown/leap/proc/on_window_bump(mob/living/carbon/source, obj/structure/window/bumped_window)
	if(!bumped_window.reinf)
		var/turf/new_turf = get_turf(bumped_window)
		bumped_window.deconstruct(disassembled = FALSE)
		source.apply_damage(damage = 5, damagetype = BRUTE)
		source.visible_message(span_warning("[source] slams [source.p_their()] body through the window!"))
		for(var/obj/structure/grille/poorgrille in new_turf)
			on_grille_bump(source, poorgrille, do_move = FALSE)
		source.forceMove(new_turf)
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

/datum/action/cooldown/mob_cooldown/leap/proc/on_grille_bump(mob/living/carbon/source, obj/structure/grille/bumped_grille, do_move = TRUE)
	bumped_grille.shock(source, 70)
	var/turf/new_turf = get_turf(bumped_grille)
	bumped_grille.deconstruct(disassembled = FALSE)
	source.apply_damage(damage = rand(0,5), damagetype = BRUTE)
	if(do_move)
		source.forceMove(new_turf)

/obj/item/dnainjector/strong_legs
	name = "\improper DNA injector (Strong Legs)"
	desc = "Makes you leap like a bunny."
	add_mutations = list(/datum/mutation/human/strong_legs)
