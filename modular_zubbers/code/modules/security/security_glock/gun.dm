/obj/item/gun/ballistic/automatic/pistol/sec_glock
	name = "\improper 'Murphy' Service Pistol"
	desc = "This 9mm monster was developed during the very first body-modding craze by Nanotrasen, built with every what-if in mind, this timeless brick is near-incapable of failure. It comes with a revolutionary quick-reload system."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "black"
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 19 //Nokia of guns, no locker breaking though
	force = 10 //same as baton
	accepted_magazine_type = /obj/item/ammo_box/magazine/security
	fire_sound = 'modular_zubbers/sound/weapons/gun/lock/shot.ogg'
	fire_delay = 5
	can_suppress = FALSE
	projectile_damage_multiplier = 1
	actions_types = list(/datum/action/item_action/toggle_mageject)
	var/magejecting = FALSE //Whether we are launching the mags or not

/obj/item/gun/ballistic/automatic/pistol/sec_glock/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/datum/action/item_action/toggle_mageject
	button_icon = 'icons/obj/weapons/guns/ammo.dmi'
	button_icon_state = "9x19p"
	name = "Toggle magazine ejection"

/obj/item/gun/ballistic/automatic/pistol/sec_glock/ui_action_click(mob/user, actiontype)
	if(!istype(actiontype, /datum/action/item_action/toggle_mageject))
		return ..()
	magejecting = !magejecting
	balloon_alert(user, "[magejecting ? "now" : "no longer"] launching empty magazines")
	playsound(user, 'sound/items/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	update_item_action_buttons()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/examine(mob/user)
	. = ..()
	. += span_notice("Only compatible with Nanotrasen-sourced 9mm magazines.")
	. += span_notice("Using it in hand when out of ammo to start a spin reload. This can only be done if you have a spare magazine in or on your belt.")
	. += span_notice("Spin reloads can be done on the move and need you only to hold your gun for their 2 second duration.")
	. += span_notice("If toggled on, spin reloads throw empty magazines in the direction you're facing, dealing damage dependant on their type.")

/obj/item/gun/ballistic/automatic/pistol/sec_glock/attack_self(mob/living/user)
	var/obj/item/belt_item = user.get_item_by_slot(ITEM_SLOT_BELT)
	var/obj/item/ammo_box/magazine/swapped_mag = istype(belt_item, accepted_magazine_type) ? belt_item : locate(accepted_magazine_type) in belt_item
	if(!magazine && !chambered) //Empty gun, load in anyhow but without delay. No mag
		if(swapped_mag)
			balloon_alert(user, "you spin your gun, loading in a mag!")
			SpinAnimation(2, 1)
			if(do_after(user, 1 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE), target = src))
				insert_magazine(user, swapped_mag) // Just put the new mag in hands off
				return
		else
			balloon_alert(user, "no spare magazines in your belt!") // We still say what's wrong
			default_behaviour(user, TRUE)
			return
	if(!magazine && chambered)
		default_behaviour(user)
		return
	if(magazine)
		if(!magazine.ammo_count() && !chambered)
			if(swapped_mag)
				balloon_alert(user, "you spin your gun, loading in a mag!")
				SpinAnimation(2, 1)
				if(do_after(user, 1 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE), target = src))
					throw_eject_magazine(user, magejecting, swapped_mag)
					return
			else
				default_behaviour(user, TRUE)
				balloon_alert(user, "no spare magazines in your belt!")
				return
	default_behaviour(user)


/obj/item/gun/ballistic/automatic/pistol/sec_glock/proc/throw_eject_magazine(mob/user, was_ejected, obj/item/ammo_box/magazine/security/belt_mag, atom/target)
	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	if(magazine.ammo_count())
		playsound(src, eject_sound, eject_sound_volume, eject_sound_vary)
	else
		playsound(src, eject_empty_sound, eject_sound_volume, eject_sound_vary)
	magazine.forceMove(drop_location())
	var/obj/item/ammo_box/magazine/security/old_mag = magazine
	if(belt_mag)
		insert_magazine(user, belt_mag)
	else
		magazine = null
		return
	old_mag.forceMove(drop_location())
	playsound(old_mag, old_mag.murphy_eject_sound, 50, TRUE)
	if(was_ejected)
		old_mag.was_ejected = TRUE
		old_mag.throw_at(get_edge_target_turf(user, user.dir), range = 7, speed = 7, thrower = user, force = 10)
	old_mag.update_appearance()
	update_appearance()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message = TRUE)
	if(!istype(AM, accepted_magazine_type))
		balloon_alert(user, "[AM.name] doesn't fit!")
		return FALSE
	if(user.transferItemToLoc(AM, src))
		magazine = AM
		if(bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			chamber_round(TRUE)
		drop_bolt()
		update_appearance()
		return TRUE
	else
		to_chat(user, span_warning("You cannot seem to get [src] out of your hands!"))
		return FALSE


// for your viewing convenience, same procs, just without bubbles
/obj/item/gun/ballistic/automatic/pistol/sec_glock/drop_bolt(mob/user = null)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/rack(mob/user = null)
	if(bolt_type == BOLT_TYPE_NO_BOLT)
		return
	if(bolt_type == BOLT_TYPE_OPEN)
		if(!bolt_locked)
			return
		bolt_locked = FALSE
	process_chamber(!chambered, FALSE)
	if(bolt_type == BOLT_TYPE_LOCKING && !chambered)
		bolt_locked = TRUE
		playsound(src, lock_back_sound, lock_back_sound_volume, lock_back_sound_vary)
	else
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
	update_appearance()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/proc/default_behaviour(mob/user = null, eject_mag_inside = FALSE) //Proc that we call to make the gun work as any gun would when not launching magazines etc
	if(!internal_magazine && magazine && eject_mag_inside) //Eject mag inside prevents someone spamming use in hand from emptying the clip they're going to throw into their hand.
		if(!magazine.ammo_count())
			eject_magazine(user)
			return
	if(bolt_type == BOLT_TYPE_NO_BOLT)
		unload_ammo(user)
		return
	if(bolt_type == BOLT_TYPE_LOCKING && bolt_locked)
		drop_bolt(user)
		return
	if (recent_rack > world.time)
		return
	recent_rack = world.time + rack_delay
	rack(user)
	return

//oh BROTHER I am NOT getting a coder of the year award with this... But yeah overriding the item_interaction was my best idea out of MULTPLE attempts. Not lazy, just stupid.
/obj/item/gun/ballistic/automatic/pistol/sec_glock/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if (.)
		return

	if (!internal_magazine && istype(tool, /obj/item/ammo_box/magazine))
		if (tac_reloads)
			eject_magazine(user)
			insert_magazine(user, tool)
			return ITEM_INTERACT_SUCCESS
	..()
