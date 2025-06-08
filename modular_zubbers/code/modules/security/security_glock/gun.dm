/obj/item/gun/ballistic/automatic/pistol/sec_glock //This is what you give to the Head of Security.
	name = "\improper 'Murphy' Service Pistol"
	desc = "This 9 mm monster was developed during the very first body-modding craze by NanoTrasen, built with every what-if in mind, this timeless brick is near-incapable of failure. 60% more bullet-per-bullet ammo may not have helped it's killing power, but it sure helped this gun hit like an actual brick when used as a bludgeon. \
	Not only that, but it's 'anti-lawsuit' heavy trigger design allows for safe spinning, if one can handle it and not hit anyone with the magazine flying out the handle."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "black"
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 19 //Nokia of guns, no locker breaking though
	force = 10 //same as baton
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm/security
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/security
	fire_sound = 'modular_zubbers/sound/weapons/gun/lock/shot.ogg'
	fire_delay = 5
	can_suppress = FALSE
	projectile_damage_multiplier = 1
	var/magejecting = 0 //whether we are launching the mags or not
	actions_types = list(/datum/action/item_action/toggle_mageject)

/datum/action/item_action/toggle_mageject
	button_icon = 'icons/obj/weapons/guns/ammo.dmi' //SKYRAT EDIT ADDITION
	button_icon_state = "9x19p" //SKYRAT EDIT ADDITION
	name = "Toggle magazine ejection"


/obj/item/gun/ballistic/automatic/pistol/sec_glock/ui_action_click(mob/user, actiontype)
	if(!istype(actiontype, /datum/action/item_action/toggle_mageject))
		return ..()
	magejecting = !magejecting
	if(!magejecting)
		balloon_alert(user, "not launching magazines")
	else
		balloon_alert(user, "launching empty magazines")

	playsound(user, 'sound/items/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	update_item_action_buttons()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/examine(mob/user)
	. = ..()
	. += span_notice("Using it in hand when out of ammo to start a spin reload. This can only be done if you have a spare magazine in or on your belt.")
	. += span_notice("Spin reloads can be done on the move and need you only to hold your gun for their 2 second duration. ")
	. += span_notice("If toggled on, spin reloads throw empty magazines in the direction you're facing, dealing damage dependant on their type. ")

// /obj/item/gun/ballistic/automatic/pistol/sec_glock/security //This is what you give to Security Officers.
// 	name = "\improper C-CK 9x25mm"
// 	desc = "The Compact Criminal Killer, or C-CK9 for short, is a semi-automatic ballistic pistol meant for regulated station defense. These are normally issued with a special firing pin that only allows firing on code blue or higher."
// 	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
// 	icon_state = "black"
// 	pin = /obj/item/firing_pin/alert_level/blue
// 	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/flathead
// 	fire_delay = 4
// 	can_suppress = FALSE
// 	projectile_damage_multiplier = 0.65

// /obj/item/gun/ballistic/automatic/pistol/sec_glock/security/rubber //This is what you give to cargo packages.
// 	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/rubber

/obj/item/gun/ballistic/automatic/pistol/sec_glock/attack_self(mob/living/user)
	var/obj/item/storage/our_belt = user.get_item_by_slot(ITEM_SLOT_BELT)
	var/obj/item/ammo_box/magazine/m9mm/security/swapped_mag = locate(/obj/item/ammo_box/magazine/m9mm/security) in our_belt.contents
	if(!magazine && swapped_mag)
		if(swapped_mag)
			if(insert_magazine(user, swapped_mag))
				SpinAnimation(2, 1)
				balloon_alert(user, "You spin your gun, loading in a mag!")
			else
				balloon_alert(user, "That magazine doesn't fit!")
		else
			balloon_alert(user, "No spare magazines in your belt!")
		return
	if(!chambered)
		if(swapped_mag)
			SpinAnimation(2, 1) //What a badass
			if(do_after(user, 1 SECONDS, timed_action_flags = ( IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE ), target = src))
				throw_eject_magazine(user, magejecting)
		else
			balloon_alert(user, "No spare magazines in your belt!")
	if(bolt_type == BOLT_TYPE_NO_BOLT)
		unload_ammo(user)
		return
	drop_bolt_silent(user)
	if(recent_rack > world.time)
		return
	recent_rack = world.time + rack_delay
	rack_silent(user)
	return

/obj/item/gun/ballistic/automatic/pistol/sec_glock/proc/throw_eject_magazine(mob/user, display_message = TRUE, obj/item/ammo_box/magazine/tac_load = null, atom/target)
	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	if(magazine.ammo_count())
		playsound(src, eject_sound, eject_sound_volume, eject_sound_vary)
	else
		playsound(src, eject_empty_sound, eject_sound_volume, eject_sound_vary)
	magazine.forceMove(drop_location())
	var/obj/item/ammo_box/magazine/old_mag = magazine
	var/obj/item/storage/our_belt = user.get_item_by_slot(ITEM_SLOT_BELT)
	var/obj/item/ammo_box/magazine/m9mm/security/swapped_mag = locate(/obj/item/ammo_box/magazine/m9mm/security) in our_belt.contents
	if(swapped_mag)
		insert_magazine(user, swapped_mag)
	else
		magazine = null
		return
	old_mag.forceMove(drop_location())
	if(istype(old_mag, /obj/item/ammo_box/magazine/m9mm/security/rocket) && magejecting)
		playsound(old_mag, 'sound/items/weapons/gun/general/rocket_launch.ogg', 50, TRUE)
	if(magejecting)
		old_mag.throw_at(get_edge_target_turf(user, user.dir), range = 7, speed = 7, thrower = user, force = 10)
	old_mag.update_appearance()
	update_appearance()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message = TRUE)
	if(!istype(AM, accepted_magazine_type))
		balloon_alert(user, "[AM.name] doesn't fit!")
		return FALSE
	user.transferItemToLoc(AM, src)
	magazine = AM
	if(bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
		chamber_round(TRUE)
	drop_bolt_silent()
	update_appearance()
	.=..()
	return TRUE

// for your viewing convenience, same procs, just without bubbles
/obj/item/gun/ballistic/proc/drop_bolt_silent(mob/user = null)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/proc/rack_silent(mob/user = null)
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
