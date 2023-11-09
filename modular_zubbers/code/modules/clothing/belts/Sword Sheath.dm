/obj/item/storage/belt/sabre/centcom
	name = "Commander's sabre sheath"
	desc = "A expensive sheath made of pure gold, and exotic fabric to house an even more expensive sword, this one has CENTRAL COMMAND etched into the gold stripe, and a nice white stripe."
	icon = 'modular_zubbers/icons/obj/clothing/belts.dmi'
	icon_state = "cent_sheath"
	inhand_icon_state = "cent_sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts.dmi'
	worn_icon_state = "cent_sheath"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_righthand.dmi'

/obj/item/storage/belt/sabre/centcom/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

	atom_storage.max_slots = 1
	atom_storage.rustle_sound = FALSE
	atom_storage.max_specific_storage = WEIGHT_CLASS_BULKY
	atom_storage.set_holdable(
		list(
			/obj/item/melee/sabre/centcom,
		)
	)

/obj/item/storage/belt/sabre/centcom/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("Alt-click it to quickly draw the blade.")

/obj/item/storage/belt/sabre/centcom/AltClick(mob/user)
	if(!user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS))
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		user.visible_message(span_notice("[user] takes [I] out of [src]."), span_notice("You take [I] out of [src]."))
		user.put_in_hands(I)
		update_appearance()
	else
		balloon_alert(user, "it's empty!")

/obj/item/storage/belt/sabre/centcom/update_icon_state()
	icon_state = initial(inhand_icon_state)
	inhand_icon_state = initial(inhand_icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(contents.len)
		icon_state += "-sabre"
		inhand_icon_state += "-sabre"
		worn_icon_state += "-sabre"
	return ..()

/obj/item/storage/belt/sabre/centcom/PopulateContents()
	new /obj/item/melee/sabre/centcom(src)
	update_appearance()