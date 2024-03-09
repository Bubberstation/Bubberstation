#define NO_DEBUG_GUH(var) message_admins("[var] [__FILE__]-[__LINE__]")
#warn REMOVE BITCHASS
/datum/component/kinetic_crusher
	/// The attached trophies.
	var/list/stored_trophies = list()
	/// How much damage to deal on mark detonation?
	var/detonation_damage
	/// How much EXTRA damage to deal on a backstab?
	var/backstab_bonus
	/// Does what you think it does.
	var/recharge_speed
	/// Callback to check against for most actions.
	var/datum/callback/attack_check
	/// Callback to check against for mark detonation.
	var/datum/callback/detonate_check
	/// Callback to execute after a successful mark detonation.
	var/datum/callback/after_detonate

	/// Are we ready to shoot another destabilizer shot?
	var/charged = TRUE
	/// COMSIG_ITEM_ATTACK procs before the damage is applied. Egh.
	var/cached_health = null

/datum/component/kinetic_crusher/Initialize(detonation_damage, backstab_bonus, recharge_speed, datum/callback/attack_check, datum/callback/detonate_check, datum/callback/after_detonate)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.detonation_damage = detonation_damage
	src.backstab_bonus = backstab_bonus
	src.recharge_speed = recharge_speed

	src.attack_check = attack_check
	src.detonate_check = detonate_check
	src.after_detonate = after_detonate

/datum/component/kinetic_crusher/RegisterWithParent(datum/parent = parent)
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(on_attack))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_afterattack))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SECONDARY, PROC_REF(on_attack_secondary))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK_SECONDARY, PROC_REF(on_afterattack_secondary))

/datum/component/kinetic_crusher/Destroy(force)
	QDEL_LIST(stored_trophies) //dont be a dummy
	QDEL_NULL(attack_check)
	QDEL_NULL(detonate_check)
	QDEL_NULL(after_detonate)
	return ..()

/datum/component/kinetic_crusher/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/obj/item/owner = parent
	examine_list += span_notice("Mark a large creature with a destabilizing force with right-click, then hit them in melee to do <b>[owner.force + detonation_damage]</b> damage.")
	examine_list += span_notice("Does <b>[owner.force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[owner.force + detonation_damage]</b>.")
	for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
		examine_list += span_notice("It has \a [trophy] attached, which causes [trophy.effect_desc()].")

/datum/component/kinetic_crusher/proc/on_update_overlays(atom/source, list/overlays)
	SIGNAL_HANDLER

	if(!charged)
		overlays += "[source.icon_state]_uncharged"

/datum/component/kinetic_crusher/proc/on_attackby(datum/source, obj/item/attacking_item, mob/user, params)
	SIGNAL_HANDLER

	if(attacking_item.tool_behaviour == TOOL_CROWBAR)
		if(!LAZYLEN(stored_trophies))
			to_chat(user, span_warning("There are no trophies on [src]."))
			return COMPONENT_NO_AFTERATTACK

		to_chat(user, span_notice("You remove [src]'s trophies."))
		attacking_item.play_tool_sound(src)
		for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
			trophy.remove_from(parent, user)
			UnregisterSignal(trophy, COMSIG_MOVABLE_MOVED)

		return COMPONENT_NO_AFTERATTACK

	if(istype(attacking_item, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/trophy = attacking_item
		trophy.add_to(parent, user, src)
		RegisterSignal(trophy, COMSIG_MOVABLE_MOVED, PROC_REF(on_trophy_moved))
		return COMPONENT_NO_AFTERATTACK

/datum/component/kinetic_crusher/proc/on_trophy_moved(obj/item/crusher_trophy/source, atom/oldloc, direction)
	SIGNAL_HANDLER

	source.remove_from(parent)

/datum/component/kinetic_crusher/proc/on_attack(obj/item/source, mob/living/target, mob/living/carbon/user)
	SIGNAL_HANDLER

	cached_health = target.health
	if(attack_check && !attack_check.Invoke(user))
		return

	if(!target.has_status_effect(/datum/status_effect/crusher_damage))
		target.apply_status_effect(/datum/status_effect/crusher_damage)

	for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
		trophy.on_melee_hit(target, user)

/datum/component/kinetic_crusher/proc/on_afterattack(obj/item/source, mob/living/target, mob/living/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(!proximity_flag || !istype(target))
		NO_DEBUG_GUH("NO PROXIMITY FLAG OR ISTYPE OR SOME SHIT. PROX:[proximity_flag], TYPE:[istype(target)].")
		return

	var/datum/status_effect/crusher_damage/damage_effect = target.has_status_effect(/datum/status_effect/crusher_damage) || target.apply_status_effect(/datum/status_effect/crusher_damage)
	if(isnum(cached_health))
		damage_effect.total_damage += cached_health - target.health //carry over from the /on_attack()
		cached_health = null

	if(detonate_check && !detonate_check.Invoke(user))
		NO_DEBUG_GUH("DETONATE CHECK FAILED SOMEHOW.")
		return

	var/datum/status_effect/crusher_mark/mark_effect = target.has_status_effect(/datum/status_effect/crusher_mark)
	if(mark_effect?.hammer_synced != src)
		NO_DEBUG_GUH("HAMMER SYNCED FAILED SOMEHOW. HAMMER:[isnull(mark_effect) ? "FUCKING GONE" : mark_effect.hammer_synced], PARENT:[parent]")
		return

	target.remove_status_effect(/datum/status_effect/crusher_mark)

	var/backstabbed = FALSE
	var/dealt_damage = detonation_damage
	if(target.dir & get_dir(user, target))
		backstabbed = TRUE
		dealt_damage += backstab_bonus
		playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, TRUE) //Seriously who spelled it wrong // i feel you old coder

	damage_effect.total_damage += dealt_damage
	new /obj/effect/temp_visual/kinetic_blast(get_turf(target))

	var/past_damage = target.maxHealth - target.health
	for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
		trophy.on_mark_detonation(target, user)

	damage_effect.total_damage += dealt_damage + target.get_total_damage() - past_damage //we did some damage, but let's not assume how much we did

	after_detonate?.InvokeAsync(user, target)
	SEND_SIGNAL(user, COMSIG_LIVING_CRUSHER_DETONATE, target, src, backstabbed)
	target.apply_damage(dealt_damage, BRUTE, blocked = target.getarmor(type = BOMB))

/datum/component/kinetic_crusher/proc/on_attack_secondary(obj/item/source, mob/living/victim, mob/living/user, params)
	SIGNAL_HANDLER

	if(attack_check?.Invoke(user))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

/datum/component/kinetic_crusher/proc/on_afterattack_secondary(obj/item/source, atom/target, mob/living/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(attack_check && !attack_check.Invoke(user))
		NO_DEBUG_GUH("ATTACK CHECK FAILED SOMEHOW.")
		return

	if(!charged)
		return

	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		NO_DEBUG_GUH("PROJ TURF ISNT LOC. GUH.")
		return

	var/obj/projectile/destabilizer/destabilizer = new(proj_turf)
	for(var/obj/item/crusher_trophy/attached_trophy as anything in stored_trophies)
		attached_trophy.on_projectile_fire(destabilizer, user)

	destabilizer.preparePixelProjectile(target, user, params2list(click_parameters))
	destabilizer.hammer_synced = src
	destabilizer.firer = user

	// just typing spawn(-1) is faster ugghhh tg
	INVOKE_ASYNC(destabilizer, TYPE_PROC_REF(/obj/projectile, fire))
	playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, TRUE)

	var/obj/item/crusher = parent
	charged = FALSE
	crusher.update_appearance()
	addtimer(CALLBACK(src, PROC_REF(recharge_shot)), recharge_speed)

/datum/component/kinetic_crusher/proc/recharge_shot()
	var/obj/item/crusher = parent
	charged = TRUE
	crusher.update_appearance()
	playsound(crusher.loc, 'sound/weapons/kenetic_reload.ogg', 60, TRUE) //why

