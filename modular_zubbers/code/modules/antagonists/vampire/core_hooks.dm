/datum/element/art/apply_moodlet(atom/source, mob/living/user, impress)
	. = ..()
	SEND_SIGNAL(user, COMSIG_LIVING_APPRAISE_ART, source)

/mob/living/carbon/transfer_blood_to(atom/movable/receiver, amount, ignore_low_blood = FALSE, ignore_incompatibility = FALSE, transfer_viruses = TRUE)
	. = ..()
	if(!.)
		return
	var/datum/antagonist/vampire/vampiredatum = IS_VAMPIRE(src)
	vampiredatum?.adjust_blood_volume(-.)

/datum/brain_trauma/special/honorbound/check_visible_guilt(mob/living/attacked_mob)
	. = ..()
	var/datum/antagonist/vampire/vampire_datum = IS_VAMPIRE(attacked_mob)
	if(vampire_datum && vampire_datum.humanity < VAMPIRE_LOW_HUMANITY)
		guilty(attacked_mob, "for being an unholy creature of the night!")

/datum/deathmatch_controller/ui_interact(mob/user, datum/tgui/ui)
	if(HAS_TRAIT(user, TRAIT_NO_OBSERVE))
		to_chat(user, span_warning("You cannot play or host deathmatch in your current form!"))
		return
	return ..()

/datum/deathmatch_controller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(HAS_TRAIT(usr, TRAIT_NO_OBSERVE))
		return
	return ..()

/obj/item/melee/blood_magic/stun/proc/effect_vampire(mob/living/target, mob/living/carbon/user)
	to_chat(user, span_userdanger("The spell violently reacts with [target], releasing a large burst of sanguine energy!"), type = MESSAGE_TYPE_COMBAT)
	to_chat(target, span_userdanger("You're flung back by a violent burst of sanguine energy, as [user] attempts to hit you with ") + span_cult_large("the blood of the Traitor!"), type = MESSAGE_TYPE_COMBAT)
	target.visible_message(
		span_warning("[user] and [target] are violently flung back by a burst of sanguine energy!"),
		ignored_mobs = list(user, target),
	)

	var/obj/effect/temp_visual/sanguine_boom/boom = new(user.loc)

	if(user.loc == target.loc)
		boom.pixel_x = -32
		boom.pixel_y = -32
	else
		var/dir = get_dir(user, target)
		if(dir & NORTH)
			boom.pixel_y = 32
		else if(dir & SOUTH)
			boom.pixel_y = -32

		if(dir & WEST)
			boom.pixel_x = -32
		else if(dir & EAST)
			boom.pixel_x = 32

	// deactivate any active powers, to ensure the vampire can experience the full force of being flung away at mach fuck
	var/datum/antagonist/vampire/vampire_datum = IS_VAMPIRE(target)
	vampire_datum.disable_all_powers(forced = TRUE)
	// they lose 25% of their current vitae too
	vampire_datum.adjust_blood_volume(-vampire_datum.current_vitae * 0.25)

	// ensure they're not buckled to anything, you are NOT escaping this bullshit
	user.buckled?.unbuckle_mob(user, force = TRUE)
	target.buckled?.unbuckle_mob(target, force = TRUE)

	playsound(user, 'modular_zubbers/sound/effects/vampires/rage_increase.ogg', vol = 100, vary = FALSE, pressure_affected = FALSE)

	flash_color(user, BLOOD_COLOR_RED, 2 SECONDS)
	flash_color(target, BLOOD_COLOR_RED, 2 SECONDS)

	// cultist gets a little bit of mercy to make it slightly more fair (they won't break an arm or something from the knockback)
	ADD_TRAIT(user, TRAIT_NEVER_WOUNDED, REF(src))
	addtimer(TRAIT_CALLBACK_REMOVE(user, TRAIT_NEVER_WOUNDED, REF(src)), 2 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

	var/turf/user_turf = get_turf(user)
	var/turf/target_turf = get_turf(target)

	// this is gonna hurt for the both of them.
	user.throw_at(get_edge_target_turf(user_turf, get_dir(target_turf, user_turf)), range = 200, speed = 5)
	target.throw_at(get_edge_target_turf(target_turf, get_dir(user_turf, target_turf)), range = 200, speed = 5)

	// they're both a bit disoriented for a moment
	target.set_confusion_if_lower(8 SECONDS)
	target.set_eye_blur_if_lower(8 SECONDS)
	user.set_confusion_if_lower(8 SECONDS)
	user.set_eye_blur_if_lower(8 SECONDS)

/obj/effect/temp_visual/sanguine_boom
	icon = 'modular_zubbers/icons/effects/vampire_64x64.dmi'
	icon_state = "sanguine_boom"
	duration = 0.41 SECONDS
