/**
 *	# Dominate;
 *
 *	Level 1 - Mesmerizes target
 *	Level 2 - Mesmerizes and mutes target
 *	Level 3 - Mesmerizes, blinds and mutes target
 *	Level 4 - Target (if at least in crit & has a mind) will revive as a Mute/Deaf Vassal for 5 minutes before dying.
 *	Level 5 - Target (if at least in crit & has a mind) will revive as a Vassal for 8 minutes before dying.
 */

#define TEMP_VASSALIZE_COST 150
#define DOMINATE_DOMINATE_XRAY_LEVEL 3
/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate
	name = "Dominate"
	button_icon_state = "power_auspex"
	background_icon_state = "tremere_power_off"
	active_background_icon_state = "tremere_power_on"
	base_background_icon_state = "tremere_power_off"
	button_icon = 'modular_zubbers/icons/mob/actions/tremere_bloodsucker.dmi'
	background_icon = 'modular_zubbers/icons/mob/actions/tremere_bloodsucker.dmi'
	level_current = 1
	button_icon_state = "power_dominate"
	power_flags = BP_AM_TOGGLE|BP_AM_STATIC_COOLDOWN
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|AB_CHECK_CONSCIOUS
	purchase_flags = TREMERE_CAN_BUY
	bloodcost = 15
	constant_bloodcost = 0.1
	target_range = 6
	mesmerize_delay = 3 SECONDS
	blind_at_level = 3
	requires_facing_target = FALSE
	blocked_by_glasses = FALSE
	/// Data huds to show while the power is active
	var/list/datahuds = list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_explanation()
	. = ..()
	. += "Click any person to, after [DisplayTimeText(mesmerize_delay)], stun them for [DisplayTimeText(get_power_time())]."
	. += "Right clicking on your victim however will apply a knockdown will confuse and slow them down for [DisplayTimeText(get_power_time())]."
	. += "A left click will completely immobilize, and blind them for the next [DisplayTimeText(get_power_time())] seconds, and will also mute them for [DisplayTimeText(get_power_time())] seconds."
	. += "While this ability is active, you will be able to see additional information about everyone in the room."
	. += "At level [DOMINATE_DOMINATE_XRAY_LEVEL], you will gain X-Ray vision while this ability is active."
	. += "At level [DOMINATE_VASSALIZE_LEVEL], while adjacent to the target, if your target is in critical condition or dead, they will instead be turned into a temporary Vassal. This will cost [TEMP_VASSALIZE_COST] blood."
	. += "If you use this on a currently dead normal Vassal, they will will not suddenly cease to live as if a temporary Vassal."
	. += "They will have complete loyalty to you, until their death in [DisplayTimeText(get_vassal_duration())] upon use."
	. += "Vassalizing or reviving a vassal will make this ability go on cooldown for [DisplayTimeText(get_vassalize_cooldown())]."

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/CheckCanTarget(atom/target_atom)
	var/mob/living/selected_target = target_atom
	if(level_current >= DOMINATE_VASSALIZE_LEVEL && (IS_VASSAL(selected_target) || selected_target.stat >= SOFT_CRIT))
		if(selected_target?.mind && owner.Adjacent(selected_target))
			return TRUE
	. = ..()
	if(!.)
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/ContinueActive(mob/living/user, mob/living/target)
	if(!target)
		return can_use(user)
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/ActivatePower(atom/target)
	. = ..()
	if(level_current >= DOMINATE_DOMINATE_XRAY_LEVEL)
		ADD_TRAIT(owner, TRAIT_XRAY_VISION, DOMINATE_TRAIT)
	for(var/hudtype in datahuds)
		var/datum/atom_hud/data_hud = GLOB.huds[hudtype]
		data_hud.show_to(owner)
	owner.update_sight()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/DeactivatePower()
	. = ..()
	if(!.)
		return
	if(level_current >= DOMINATE_DOMINATE_XRAY_LEVEL)
		REMOVE_TRAIT(owner, TRAIT_XRAY_VISION, DOMINATE_TRAIT)
	for(var/hudtype in datahuds)
		var/datum/atom_hud/data_hud = GLOB.huds[hudtype]
		data_hud.hide_from(owner)
	owner.update_sight()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/FireTargetedPower(atom/target, params)
	var/mob/living/target_mob = target
	var/mob/living/user = owner
	if(target_mob.stat != CONSCIOUS && level_current >= DOMINATE_VASSALIZE_LEVEL)
		if(user.Adjacent(target))
			attempt_vassalize(target, user)
		else
			owner.balloon_alert(owner, "too far to vassalize!")
		return TRUE
	return ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/attempt_vassalize(mob/living/target, mob/living/user)
	owner.balloon_alert(owner, "attempting to vassalize.")
	var/datum/antagonist/vassal/vassal = IS_VASSAL(target)
	if(!do_after(user, 6 SECONDS, target, NONE, TRUE))
		return FALSE

	if(vassal?.master == bloodsuckerdatum_power)
		if(target.stat != DEAD)
			owner.balloon_alert(owner, "not dead!")
			return FALSE
		PowerActivatedSuccesfully(get_vassalize_cooldown())
		to_chat(user, span_warning("We revive [target]!"))
		owner.balloon_alert(owner, "successfully revived!")
		target.mind?.grab_ghost()
		target.revive(ADMIN_HEAL_ALL)
		pay_cost(TEMP_VASSALIZE_COST - bloodcost)
		log_combat(owner, target, "tremere revived", addition="Revived their vassal using dominate")
		return FALSE
	if(!bloodsuckerdatum_power.make_vassal(target) )
		owner.balloon_alert(owner, "not a valid target for vassalization!.")
		return

	/*if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("Their body refuses to react..."))
		return*/
	PowerActivatedSuccesfully(get_vassalize_cooldown())
	to_chat(user, span_warning("We revive [target]!"))
	target.mind?.grab_ghost()
	target.revive(ADMIN_HEAL_ALL)
	var/datum/antagonist/vassal/vassaldatum = target.mind.has_antag_datum(/datum/antagonist/vassal)
	vassaldatum.special_type = TREMERE_VASSAL //don't turn them into a favorite please
	var/living_time = get_vassal_duration()
	log_combat(owner, target, "tremere mindslaved", addition="Revived and converted [target] into a temporary tremere vassal for [DisplayTimeText(living_time)].")
	if(level_current <= 4)
		target.add_traits(list(TRAIT_MUTE, TRAIT_DEAF), DOMINATE_TRAIT)
	if(!living_time)
		return
	user.balloon_alert(user, "only [DisplayTimeText(living_time)] left to live!")
	to_chat(user, span_warning("You will only live for [DisplayTimeText(living_time)]! Obey your master and go out in a blaze of glory!"))
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate, end_possession), target), living_time)
	// timer that only the master and thrall can see
	setup_timer(user, target, living_time)
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(end_possession))
	pay_cost(TEMP_VASSALIZE_COST - bloodcost)
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/setup_timer(mob/living/user, mob/living/target, living_time)
	var/list/show_to = list(user, target)
	if(bloodsuckerdatum_power && length(bloodsuckerdatum_power.vassals))
		show_to += bloodsuckerdatum_power.vassals
	var/atom/movable/screen/text/screen_timer/attached/timer = new(null, list(target), target, living_time, "Death in ${timer}", 32, 0, null, null, target)
	QDEL_IN(timer, living_time)
	timer.invisibility = INVISIBILITY_ABSTRACT
	timer.mouse_opacity = MOUSE_OPACITY_OPAQUE // debug vv reasons

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/end_possession(mob/living/user)
	if(!user || QDELETED(user))
		return
	user.remove_traits(list(TRAIT_MUTE, TRAIT_DEAF), DOMINATE_TRAIT)
	if(!HAS_TRAIT(user, TRAIT_NOBLOOD))
		user.blood_volume = BLOOD_VOLUME_BAD
	user.death()
	if(!IS_VASSAL(user))
		to_chat(user, span_warning("You feel the blood keeping you alive run out!"))
		return
	to_chat(user, span_warning("You feel the Blood of your Master run out!"))
	user.mind?.remove_antag_datum(/datum/antagonist/vassal)
	if(user.stat == DEAD)
		return
	user.death()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_vassal_duration()
	return (1 MINUTES) * level_current

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_vassalize_cooldown()
	return cooldown_time * 3

#undef TEMP_VASSALIZE_COST
#undef DOMINATE_DOMINATE_XRAY_LEVEL
