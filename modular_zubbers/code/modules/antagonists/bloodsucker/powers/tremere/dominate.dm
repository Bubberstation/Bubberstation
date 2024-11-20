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
#define DOMINATE_XRAY_LEVEL 3
#define DOMINATE_NON_MUTE_VASSALIZE_LEVEL 4
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
	purchase_flags = TREMERE_CAN_BUY
	bloodcost = 15
	constant_bloodcost = 0.1
	target_range = 6
	mesmerize_delay = 4 SECONDS
	blind_at_level = 3
	requires_facing_target = FALSE
	blocked_by_glasses = FALSE
	knockdown_on_secondary = TRUE
	/// Data huds to show while the power is active
	var/list/datahuds = list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC, DATA_HUD_BOT_PATH)
	var/list/thralls = list()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/Remove(mob/removed_from)
	. = ..()
	for(var/thrall in thralls)
		if(!thrall)
			continue
		end_possession(thrall)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_desc_extended()
	. = ..()
	if(level_current >= DOMINATE_VASSALIZE_LEVEL)
		. += "If your target is in critical condition or dead, they will instead be turned into a temporary Vassal. This will cost [TEMP_VASSALIZE_COST] blood. Pre-existing dead vassals will simply be revived."

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_explanation_extended()
	. = list()
	. += "Click any person to, after [DisplayTimeText(mesmerize_delay)], stun them for [DisplayTimeText(get_power_time())]."
	. += "Right clicking on your victim however will apply a knockdown will confuse and slow them down for [DisplayTimeText(get_power_time())]."
	. += "A left click will completely immobilize, and blind them for the next [DisplayTimeText(get_power_time())] seconds, and will also mute them for [DisplayTimeText(get_power_time())] seconds."
	. += "While this ability is active, you will be able to see additional information about everyone in the room."
	. += "At level [DOMINATE_XRAY_LEVEL], you will gain X-Ray vision while this ability is active."
	. += "At level [DOMINATE_VASSALIZE_LEVEL], while adjacent to the target, if your target is in critical condition or dead, they will instead be turned into a temporary Vassal. This will cost [TEMP_VASSALIZE_COST] blood."
	. += "The victim must have atleast [BLOOD_VOLUME_BAD] blood to be vassalized."
	. += "The vassal will be mute and deaf if the level of [src] is not at least [DOMINATE_NON_MUTE_VASSALIZE_LEVEL]"
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
	if(level_current >= DOMINATE_XRAY_LEVEL)
		ADD_TRAIT(owner, TRAIT_XRAY_VISION, DOMINATE_TRAIT)
	for(var/hudtype in datahuds)
		var/datum/atom_hud/data_hud = GLOB.huds[hudtype]
		data_hud.show_to(owner)
	owner.update_sight()
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	if(level_current >= DOMINATE_XRAY_LEVEL)
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
			if(IS_VASSAL(target_mob))
				owner.balloon_alert(owner, "too far to revive!")
			else
				owner.balloon_alert(owner, "too far to vassalize!")
		return TRUE
	return ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/attempt_vassalize(mob/living/target, mob/living/user)
	owner.face_atom(target)
	var/datum/antagonist/vassal/vassal = IS_VASSAL(target)
	if(!victim_has_blood(target))
		return FALSE
	if(vassal)
		owner.balloon_alert(owner, "attempting to revive.")
	else
		owner.balloon_alert(owner, "attempting to vassalize.")
	if(!do_after(user, 6 SECONDS, target, NONE, TRUE))
		return FALSE
	if(!victim_has_blood(target))
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
	// no escaping at this point
	target.mind?.grab_ghost(TRUE)
	target.revive(ADMIN_HEAL_ALL)
	var/datum/antagonist/vassal/vassaldatum = target.mind.has_antag_datum(/datum/antagonist/vassal)
	vassaldatum.special_type = TREMERE_VASSAL //don't turn them into a favorite please
	var/living_time = get_vassal_duration()
	log_combat(owner, target, "tremere mindslaved", addition="Revived and converted [target] into a temporary tremere vassal for [DisplayTimeText(living_time)].")
	if(level_current <= DOMINATE_NON_MUTE_VASSALIZE_LEVEL)
		target.add_traits(list(TRAIT_MUTE, TRAIT_DEAF), DOMINATE_TRAIT)
	user.balloon_alert(target, "only [DisplayTimeText(living_time)] left to live!")
	to_chat(target, span_warning("You will only live for [DisplayTimeText(living_time)]! Obey your master and go out in a blaze of glory!"))
	var/timer_id = addtimer(CALLBACK(src, PROC_REF(end_possession), target), living_time, TIMER_STOPPABLE)
	// timer that only the master and thrall can see
	setup_timer(user, target, living_time, timer_id)
	thralls += target
	RegisterSignals(target, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(end_possession), timer_id)
	RegisterSignal(vassaldatum, COMSIG_ANTAGONIST_REMOVED, PROC_REF(on_antag_datum_removal), target, timer_id)
	pay_cost(TEMP_VASSALIZE_COST - bloodcost)
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/victim_has_blood(mob/living/target)
	// you can always revive non-temporary vassals
	if(IS_VASSAL(target))
		return TRUE
	if(target.blood_volume < BLOOD_VOLUME_BAD)
		owner.balloon_alert(owner, "not enough blood in victim!")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/setup_timer(mob/living/user, mob/living/target, living_time, timer_id)
	var/list/show_to = list(user, target)
	if(bloodsuckerdatum_power && length(bloodsuckerdatum_power.vassals))
		for(var/datum/antagonist/vassal in bloodsuckerdatum_power.vassals)
			if(!vassal?.owner?.current)
				continue
			show_to += vassal.owner.current
	new /atom/movable/screen/text/screen_timer/attached(null, show_to, timer_id, "Dies in ${timer}", null, null, target)
	new /atom/movable/screen/text/screen_timer(null, target, timer_id, "You die in ${timer}")

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/on_antag_datum_removal(datum/antagonist/vassal, mob/living/thrall, timer_id)
	end_possession(thrall, timer_id)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/end_possession(mob/living/user, timer_id)
	if(timer_id)
		deltimer(timer_id)
	if(!user)
		CRASH("[src] end_possession called with no user!")
	if(!(user in thralls))
		return
	thralls -= user
	user.remove_traits(list(TRAIT_MUTE, TRAIT_DEAF), DOMINATE_TRAIT)
	if(!HAS_TRAIT(user, TRAIT_NOBLOOD))
		user.blood_volume = 0
	if(!IS_VASSAL(user))
		to_chat(user, span_warning("You feel the blood keeping you alive run out!"))
		return
	to_chat(user, span_warning("You feel the Blood of your Master run out!"))
	user.mind?.remove_antag_datum(/datum/antagonist/vassal)
	if(user.stat == DEAD)
		return
	user.death()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_vassal_duration()
	return 4 MINUTES * max(level_current, 1)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_vassalize_cooldown()
	return cooldown_time * 3

#undef TEMP_VASSALIZE_COST
#undef DOMINATE_XRAY_LEVEL
