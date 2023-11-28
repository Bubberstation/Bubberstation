/obj/item/gun/ballistic/bow/tribalbow
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	lefthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/back.dmi'
	inhand_icon_state = "bow"
	icon_state = "bow_unloaded"
	base_icon_state = "bow"
	worn_icon_state = "bow"
	slot_flags = ITEM_SLOT_BACK
<<<<<<< HEAD

/obj/item/gun/ballistic/bow/tribalbow/update_icon()
=======
	item_flags = NEEDS_PERMIT
	casing_ejector = FALSE
	internal_magazine = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL //so ashwalkers can use it
	has_gun_safety = FALSE

/obj/item/gun/ballistic/tribalbow/shoot_with_empty_chamber()
	return

/obj/item/gun/ballistic/tribalbow/chamber_round(keep_bullet = FALSE, spin_cylinder, replace_new_round)
	chambered = magazine.get_round(1)

/obj/item/gun/ballistic/tribalbow/process_chamber()
	chambered = null
	magazine.get_round(0)
	update_icon()

/obj/item/gun/ballistic/tribalbow/attack_self(mob/living/user)
	if (chambered)
		var/obj/item/ammo_casing/AC = magazine.get_round(0)
		user.put_in_hands(AC)
		chambered = null
		to_chat(user, span_notice("You gently release the bowstring, removing the arrow."))
	else if (get_ammo())
		var/obj/item/I = user.get_active_held_item()
		if (do_after(user, 1 SECONDS, I))
			to_chat(user, span_notice("You draw back the bowstring."))
			playsound(src, 'modular_skyrat/modules/tribal_extended/sound/sound_weapons_bowdraw.ogg', 75, 0) //gets way too high pitched if the freq varies
			chamber_round()
	update_icon()

/obj/item/gun/ballistic/tribalbow/attackby(obj/item/I, mob/user, params)
	if (magazine.attackby(I, user, params, 1))
		to_chat(user, span_notice("You notch the arrow."))
		update_icon()

/obj/item/gun/ballistic/tribalbow/update_icon()
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847
	. = ..()
	icon_state = "[base_icon_state]_[get_ammo() ? (chambered ? "firing" : "loaded") : "unloaded"]"


/obj/item/gun/ballistic/bow/tribalbow/ashen
	name = "bone bow"
	desc = "Some sort of primitive projectile weapon made of bone and wrapped sinew, oddly robust."
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "ashenbow_unloaded"
	base_icon_state = "ashenbow"
	inhand_icon_state = "ashenbow"
	worn_icon_state = "ashenbow"
	force = 20

/obj/item/gun/ballistic/bow/tribalbow/pipe
	name = "pipe bow"
	desc = "Portable and sleek, but you'd be better off hitting someone with a pool noodle."
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "pipebow_unloaded"
	base_icon_state = "pipebow"
	inhand_icon_state = "pipebow"
	worn_icon_state = "pipebow"
	force = 10
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
