/**
 *	# Dominate;
 *
 *	Level 1 - Mesmerizes and mutes target
 *	Level 2 - Can mesmerize OR use on a crit or dead target to revive as a temporary Vassal for 5 minutes before dying.
 *	Level 3 - Same as above but gives x-ray vision while toggled ready
 *	Level 4 - Temporary ghouls will no longer be soft-spoken/hard of hearing
 */

#define TEMP_GHOUL_COST 150
#define DOMINATE_GHOUL_LEVEL 2
#define DOMINATE_XRAY_LEVEL 3
#define DOMINATE_NON_MUTE_GHOUL_LEVEL 4

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
	target_range = 5
	mesmerize_delay = 4 SECONDS
	blind_at_level = 3
	blocked_by_glasses = FALSE
	/// Data huds to show while the power is active
	var/list/datahuds = list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC, DATA_HUD_BOT_PATH)
	/// assoc list of timer_id to ghoul datum
	var/list/ghouls = list()
	var/ghoul_creation_time = 6 SECONDS

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/Remove(mob/removed_from)
	. = ..()
	for(var/datum/antagonist/thrall as anything in ghouls)
		end_possession(thrall)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_desc_extended()
	. = ..()
	if(level_current >= DOMINATE_GHOUL_LEVEL)
		. += "If your target is in critical condition or dead, they will instead be turned into a temporary Vassal. This will cost [TEMP_GHOUL_COST] blood. Pre-existing dead ghouls will simply be revived."

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_explanation_extended()
	. = list()
	. += "Click any person to, after [DisplayTimeText(mesmerize_delay)], stun them for [DisplayTimeText(get_power_time())]."
	. += "Casting [src] will completely immobilize, and blind them for the next [DisplayTimeText(get_power_time())], and will also mute them for [DisplayTimeText(get_power_time())]."
	. += "While this ability is active, you will be able to see additional information about everyone in the room."
	. += "At level [DOMINATE_XRAY_LEVEL], you will gain X-Ray vision while this ability is active."
	. += "At level [DOMINATE_GHOUL_LEVEL], while adjacent to the target, if your target is in critical condition or dead, they will instead be turned into a temporary Vassal. This will cost [TEMP_GHOUL_COST] blood."
	. += "The victim must have atleast [BLOOD_VOLUME_BAD] blood to be ghouled."
	. += "The ghoul will be unable to talk and hear well if the level of [src] is not at least [DOMINATE_NON_MUTE_GHOUL_LEVEL]"
	. += "If you use this on a currently dead normal Vassal, they will will not suddenly cease to live as if a temporary Vassal."
	. += "They will have complete loyalty to you, until their death in [DisplayTimeText(get_ghoul_duration())] upon use."
	. += "Vassalizing or reviving a ghoul will make this ability go on cooldown for [DisplayTimeText(get_ghoulize_cooldown())]."

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/CheckCanTarget(atom/target_atom)
	var/mob/living/selected_target = target_atom
	if(level_current >= DOMINATE_GHOULIZE_LEVEL && selected_target.stat >= SOFT_CRIT)
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

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/DeactivatePower(deactivate_flags)
	..()
	if(level_current >= DOMINATE_XRAY_LEVEL)
		REMOVE_TRAIT(owner, TRAIT_XRAY_VISION, DOMINATE_TRAIT)
	for(var/hudtype in datahuds)
		var/datum/atom_hud/data_hud = GLOB.huds[hudtype]
		data_hud.hide_from(owner)
	owner.update_sight()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/FireTargetedPower(atom/target, params)
	var/mob/living/target_mob = target
	var/mob/living/user = owner
	if(target_mob.stat != CONSCIOUS && level_current >= DOMINATE_GHOULIZE_LEVEL)
		if(user.Adjacent(target))
			attempt_ghoulize(target, user)
			return TRUE
		else
			if(IS_GHOUL(target_mob))
				owner.balloon_alert(owner, "too far to revive!")
			else
				owner.balloon_alert(owner, "too far to ghoul!")
			return TRUE
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/attempt_ghoulize(mob/living/target, mob/living/user)
	owner.face_atom(target)
	var/datum/antagonist/ghoul/ghoul = IS_GHOUL(target)
	if(!victim_has_blood(target))
		return FALSE
	if(target.can_block_magic(BLOODSUCKER_ANTIMAGIC))
		to_chat(target, span_hypnophrase("You can feel a insidious force trying to take over your mind, but manage to resist!"))
		owner.balloon_alert(owner, "[target] resists your attempt to [src] them.")
		return FALSE
	if(!bloodsuckerdatum_power.can_make_ghoul(target))
		owner.balloon_alert(owner, "not a valid target for ghouling!.")
		return FALSE
	if(ghoul)
		owner.balloon_alert(owner, "attempting to revive.")
	else
		if(!bloodsuckerdatum_power.can_make_ghoul(target))
			return FALSE
		owner.balloon_alert(owner, "attempting to ghoulize.")
	if(!do_after(user, ghoul_creation_time, target, NONE, TRUE))
		return FALSE
	if(!victim_has_blood(target))
		return FALSE
	if(HAS_MIND_TRAIT(target, TRAIT_UNCONVERTABLE))
		owner.balloon_alert(owner, "their body refuses to react...")
		return FALSE
	if(!target?.mind || HAS_TRAIT(target, TRAIT_DNR))
		owner.balloon_alert(owner, "there's no soul...")
		return FALSE
	if(ghoul?.master == bloodsuckerdatum_power)
		if(target.stat != DEAD)
			owner.balloon_alert(owner, "not dead!")
			return FALSE
		target.mind?.grab_ghost()
		target.revive(ADMIN_HEAL_ALL)
		power_activated_successfully(cost_override = TEMP_GHOUL_COST, cooldown_override = get_ghoulize_cooldown())
		to_chat(user, span_warning("We revive [target]!"))
		owner.balloon_alert(owner, "successfully revived!")
		log_combat(owner, target, "tremere revived", addition = "Revived their ghoul using dominate")
		return FALSE
	var/datum/antagonist/ghoul/ghoul_datum = bloodsuckerdatum_power.make_ghoul(target) //don't turn them into a favorite please
	if(!ghoul_datum)
		owner.balloon_alert(owner, "not a valid target for ghoulizing!")
		return FALSE
	// no escaping at this point
	target.mind?.grab_ghost(TRUE)
	target.revive(ADMIN_HEAL_ALL)
	INVOKE_ASYNC(ghoul_datum, TYPE_PROC_REF(/datum, ui_interact), target) // make sure they see the ghoul popup!!
	power_activated_successfully(cost_override = TEMP_GHOUL_COST, cooldown_override = get_ghoulize_cooldown())
	to_chat(user, span_warning("We revive [target]!"))
	var/living_time = get_ghoul_duration()
	log_combat(owner, target, "tremere mindslaved", addition = "Revived and converted [target] into a temporary tremere ghoul for [DisplayTimeText(living_time)].")
	if(level_current <= DOMINATE_NON_MUTE_GHOUL_LEVEL)
		target.add_traits(list(TRAIT_SOFTSPOKEN, TRAIT_DEAF), DOMINATE_TRAIT)
	user.balloon_alert(target, "only [DisplayTimeText(living_time)] left to live!")
	to_chat(target, span_warning("You will only live for [DisplayTimeText(living_time)]! Obey your master and go out in a blaze of glory!"))
	var/timer_id = addtimer(CALLBACK(src, PROC_REF(end_possession), ghoul_datum), living_time, TIMER_STOPPABLE)
	// timer that only the master and thrall can see
	setup_timer(user, target, living_time, timer_id)
	ghouls[ghoul_datum] = timer_id
	RegisterSignals(target, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_death))
	RegisterSignal(target.mind, COMSIG_ANTAGONIST_REMOVED, PROC_REF(on_antag_datum_removal))
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/victim_has_blood(mob/living/target)
	// you can always revive non-temporary ghoul
	if(IS_GHOUL(target))
		return TRUE
	if(target.blood_volume < BLOOD_VOLUME_BAD)
		owner.balloon_alert(owner, "not enough blood in victim!")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/setup_timer(mob/living/user, mob/living/target, living_time, timer_id)
	var/list/show_to = list(user)
	if(bloodsuckerdatum_power && length(bloodsuckerdatum_power.ghouls))
		for(var/datum/antagonist/ghoul in bloodsuckerdatum_power.ghouls)
			if(isnull(ghoul?.owner?.current))
				continue
			show_to |= ghoul.owner.current

	new /atom/movable/screen/text/screen_timer/attached(null, show_to, timer_id, "Dies in ${timer}", -16, 32, target)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/on_antag_datum_removal(datum/mind/mind, datum/antagonist/ghoul)
	end_possession(ghoul, FALSE)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/on_death(mob/living/thrall)
	var/ghoul = IS_GHOUL(thrall)
	if(isnull(ghoul))
		return
	end_possession(ghoul)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/end_possession(datum/antagonist/ghoul, remove_antag = TRUE)
	SIGNAL_HANDLER
	if(!ghouls[ghoul])
		return
	if(!istype(ghoul))
		CRASH("[src] end_possession called with non-ghoul [ghoul]!")
	var/mob/living/user = ghoul?.owner?.current
	var/ghoul_timer = ghouls[ghoul]
	if(!istype(user))
		ghouls -= ghoul
		return
	if(ghoul_timer)
		deltimer(ghoul_timer)
	user.remove_traits(list(TRAIT_SOFTSPOKEN, TRAIT_DEAF), DOMINATE_TRAIT)
	UnregisterSignal(user, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	UnregisterSignal(user.mind, COMSIG_ANTAGONIST_REMOVED)
	if(!HAS_TRAIT(user, TRAIT_NOBLOOD))
		user.blood_volume = 0
	to_chat(user, span_warning("You feel the Blood of your Master run out!"))
	ghouls -= ghoul
	if(remove_antag)
		user.mind?.remove_antag_datum(/datum/antagonist/ghoul)
	if(user.stat == DEAD)
		return
	user.death()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_ghoul_duration()
	return 4 MINUTES * max(level_current, 1)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_ghoulize_cooldown()
	return cooldown_time * 3

#undef TEMP_GHOUL_COST
#undef DOMINATE_XRAY_LEVEL
#undef DOMINATE_NON_MUTE_GHOUL_LEVEL
