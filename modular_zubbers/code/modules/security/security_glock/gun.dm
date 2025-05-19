/obj/item/gun/ballistic/automatic/pistol/sec_glock //This is what you give to the Head of Security.
	name = "\improper 'Murphy' Service Pistol"
	desc = "This 9 mm monster was developed during the very first body-modding craze by NanoTrasen, built with every what-if in mind, this timeless brick is near-incapable of failure. 60% more bullet-per-bullet ammo may not have helped it's killing power, but it sure helped this gun hit like an actual brick when used as a bludgeon. \
	Not only that, but it's 'anti-lawsuit' heavy trigger design allows for safe spinning, if one can handle it and not hit anyone with the magazine flying out the handle."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "silver"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm
	throwforce = 19 //Nokia of guns, no locker breaking though
	force = 10 //same as baton
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm/security
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/security
	fire_sound = 'modular_zubbers/sound/weapons/gun/lock/shot.ogg'
	fire_delay = 3
	fire_delay = 5
	can_suppress = FALSE
	projectile_damage_multiplier = 0.75
	projectile_damage_multiplier = 1
	wound_bonus = -10
	bare_wound_bonus = -10

/obj/item/gun/ballistic/automatic/pistol/sec_glock/examine(mob/user)
	. = ..()
	. += "Use it in hand to spin the gun, ejecting the magazine at wherever you're aiming and performing a quick reload."
	. += ""

/obj/item/gun/ballistic/automatic/pistol/sec_glock/security //This is what you give to Security Officers.
	name = "\improper C-CK 9x25mm"
	desc = "The Compact Criminal Killer, or C-CK9 for short, is a semi-automatic ballistic pistol meant for regulated station defense. These are normally issued with a special firing pin that only allows firing on code blue or higher."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "black"
	pin = /obj/item/firing_pin/alert_level/blue
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/flathead
	fire_delay = 4
	can_suppress = FALSE
	projectile_damage_multiplier = 0.65

/obj/item/gun/ballistic/automatic/pistol/sec_glock/security/rubber //This is what you give to cargo packages.
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/rubber
/obj/item/gun/ballistic/automatic/pistol/sec_glock/attack_self(mob/living/user)
	if(!chambered)
		var/obj/item/storage/our_belt = user.get_item_by_slot(ITEM_SLOT_BELT)
		var/obj/item/ammo_box/magazine/m9mm/security/swapped_mag = locate(/obj/item/ammo_box/magazine/m9mm/security) in our_belt.contents
		if(swapped_mag)
			user.balloon_alert_to_viewers("Eat Lead!")
			SpinAnimation(3, 1) //What a badass
			if(do_after(user, 1 SECONDS, timed_action_flags = ( IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE ), target = src))
				throw_eject_magazine(user)
		return
	if(bolt_type == BOLT_TYPE_NO_BOLT)
		unload_ammo(user)
		return
	drop_bolt(user)
	if (recent_rack > world.time)
		return
	recent_rack = world.time + rack_delay
	rack(user)
	return

/obj/item/gun/ballistic/automatic/pistol/sec_glock/proc/throw_eject_magazine(mob/user, display_message = TRUE, obj/item/ammo_box/magazine/tac_load = null, atom/target)
	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	if (magazine.ammo_count())
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
	if(istype(old_mag, /obj/item/ammo_box/magazine/m9mm/security/rocket))
		playsound(old_mag, 'sound/items/weapons/gun/general/rocket_launch.ogg', 50, TRUE)
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
	drop_bolt(user)
	update_appearance()
	.=..()
	return TRUE
