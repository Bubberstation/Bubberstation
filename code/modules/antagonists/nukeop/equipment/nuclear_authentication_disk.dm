/obj/item/disk
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	w_class = WEIGHT_CLASS_TINY
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	icon_state = "datadisk0"
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound = 'sound/items/handling/disk_pickup.ogg'

// DAT FUKKEN DISK.
/obj/item/disk/nuclear
	name = "nuclear authentication disk"
	desc = "Better keep this safe."
	icon_state = "nucleardisk"
	max_integrity = 250
	armor_type = /datum/armor/disk_nuclear
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	/// Whether we're a real nuke disk or not.
	var/fake = FALSE
	VAR_PRIVATE/secure_time = 0 // BUBBER EDIT
	VAR_PRIVATE/secure = FALSE // BUBBER EDIT
	VAR_PRIVATE/loneop_called = FALSE

/datum/armor/disk_nuclear
	bomb = 30
	fire = 100
	acid = 100

/obj/item/disk/nuclear/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bed_tuckable, mapload, 6, -6, 0)

	if(!fake)
		AddComponent(/datum/component/stationloving, !fake)
		AddComponent(/datum/component/keep_me_secure, CALLBACK(src, PROC_REF(secured_process)), CALLBACK(src, PROC_REF(unsecured_process)), 10)
		SSpoints_of_interest.make_point_of_interest(src)
	else
		// Ensure fake disks still have examine text, but dont actually do anything
		AddComponent(/datum/component/keep_me_secure)

/obj/item/disk/nuclear/proc/secured_process(last_move)
	secure_time++
	if(secure_time >= 10)
		secure = TRUE

/obj/item/disk/nuclear/proc/unsecured_process(last_move)
	if(secure)
		secure_time = max(0, secure_time - 1)
		if(secure_time == 0)
			secure = FALSE

	var/turf/new_turf = get_turf(src)
	if((last_move < world.time - 500 SECONDS && !secure) || (isspaceturf(new_turf) && prob(20)) && loc == new_turf)
		secure_time = 0
		var/datum/storyteller/ctl = SSstorytellers?.active
		if(!ctl)
			return
		ask_to_storyteller(ctl)

/obj/item/disk/nuclear/proc/ask_to_storyteller(datum/storyteller/ctl)
	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_ANTAGS) && !loneop_called)
		return
	var/datum/round_event_control/antagonist/from_ghosts/loneop/loneop = locate() in SSstorytellers.events_by_id
	if(ctl.planner.is_event_in_timeline(loneop))
		return
	var/offset = ctl.planner.get_next_event_delay(loneop, ctl)
	if(ctl.planner.try_plan_event(loneop, offset))
		loneop_called = TRUE
		message_admins("The nuclear authentication disk has been left unsecured! And [ctl.name] deploy lone operative.")
	secure = TRUE
	secure_time += 2 MINUTES


/obj/item/disk/nuclear/proc/is_secure()
	return secure

/obj/item/disk/nuclear/examine(mob/user)
	. = ..()
	if(!fake)
		return

	if(isobserver(user) || HAS_MIND_TRAIT(user, TRAIT_DISK_VERIFIER))
		. += span_warning("The serial numbers on [src] are incorrect.")

/*
 * You can't accidentally eat the nuke disk, bro
 */
/obj/item/disk/nuclear/on_accidental_consumption(mob/living/carbon/M, mob/living/carbon/user, obj/item/source_item, discover_after = TRUE)
	M.visible_message(span_warning("[M] looks like [M.p_theyve()] just bitten into something important."), \
						span_warning("Wait, is this the nuke disk?"))

	return discover_after

/obj/item/disk/nuclear/attackby(obj/item/weapon, mob/living/user, list/modifiers, list/attack_modifiers)
	if(istype(weapon, /obj/item/claymore/highlander) && !fake)
		var/obj/item/claymore/highlander/claymore = weapon
		if(claymore.nuke_disk)
			to_chat(user, span_notice("Wait... what?"))
			qdel(claymore.nuke_disk)
			claymore.nuke_disk = null
			return

		user.visible_message(
			span_warning("[user] captures [src]!"),
			span_userdanger("You've got the disk! Defend it with your life!"),
		)
		forceMove(claymore)
		claymore.nuke_disk = src
		return TRUE

	return ..()

/obj/item/disk/nuclear/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is going delta! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(src, 'sound/announcer/alarm/nuke_alarm.ogg', 50, -1, TRUE)
	for(var/i in 1 to 100)
		addtimer(CALLBACK(user, TYPE_PROC_REF(/atom, add_atom_colour), (i % 2)? COLOR_VIBRANT_LIME : COLOR_RED, ADMIN_COLOUR_PRIORITY), i)
	addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 101)
	return MANUAL_SUICIDE

/obj/item/disk/nuclear/proc/manual_suicide(mob/living/user)
	user.remove_atom_colour(ADMIN_COLOUR_PRIORITY)
	user.visible_message(span_suicide("[user] is destroyed by the nuclear blast!"))
	user.adjust_oxy_loss(200)
	user.death(FALSE)

/obj/item/disk/nuclear/fake
	fake = TRUE

/obj/item/disk/nuclear/fake/obvious
	name = "cheap plastic imitation of the nuclear authentication disk"
	desc = "How anyone could mistake this for the real thing is beyond you."
