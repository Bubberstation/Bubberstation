/obj/item/mod/control/pre_equipped/derelict
	allow_ai = FALSE
	theme = /datum/mod_theme/derelict_mod
	applied_modules = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/mind_swap,
		/obj/item/mod/module/borg_takeover,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/mind_swap,
	)

/obj/item/mod/control/pre_equipped/derelict/allow_attack_hand_drop(mob/user)
	to_chat(user, "You find yourself unwilling to remove the control unit.")
	return

/obj/item/mod/control/pre_equipped/derelict/mouse_drop_dragged(atom/over_object, mob/user)
	to_chat(user, "You find yourself unwilling to remove the control unit.")
	return

/obj/item/mod/control/pre_equipped/derelict/equipped(mob/user, slot, initial)
	. = ..()
	if(slot == ITEM_SLOT_BACK)
		user.mind.add_antag_datum(/datum/antagonist/derelict_host)

/obj/item/mod/control/pre_equipped/derelict/dropped(mob/user)
	. = ..()
	user.mind.remove_antag_datum(/datum/antagonist/derelict_host)


