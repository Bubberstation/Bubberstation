#define MILLSTONE_STAMINA_MINIMUM 50 //What is the amount of stam damage that we prevent mill use at
#define MILLSTONE_STAMINA_USE 100 //How much stam damage is given to people when the mill is used

/obj/structure/millstone
	name = "millstone"
	desc = "Two big disks of something heavy and tough. Put a plant between them and spin, and you'll end up with seeds and a really ground up plant."
	icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/millstone.dmi'
	icon_state = "millstone"
	density = TRUE
	anchored = TRUE
	max_integrity = 200
	pass_flags = PASSTABLE
	custom_materials = list(/datum/material/stone = SHEET_MATERIAL_AMOUNT  * 6)
	/// The maximum number of items this structure can store
	var/maximum_contained_items = 10

/obj/structure/millstone/examine(mob/user)
	. = ..()

	. += span_notice("It currently contains <b>[length(contents)]/[maximum_contained_items]</b> items.")
	. += span_notice("You can process [src]'s contents with <b>Right Click</b>")
	. += span_notice("You can empty all of the items out of it with <b>Alt Click</b>")

	if(length(contents))
		. += span_notice("Inside, you can see:")
		var/list/stuff_inside = list()
		for(var/obj/thing as anything in contents)
			stuff_inside[thing.type] += 1

		for(var/obj/thing as anything in stuff_inside)
			. += span_notice("&bull; [stuff_inside[thing]] [initial(thing.name)]\s")

		. += span_notice("And it can fit <b>[maximum_contained_items - length(contents)]</b> more items in it.")
	else
		. += span_notice("It can hold [maximum_contained_items], and there is nothing in it presently.")

/obj/structure/millstone/Destroy()
	drop_everything_contained()
	return ..()

/obj/structure/millstone/AltClick(mob/user)
	if(!length(contents))
		balloon_alert(user, "nothing inside")
		return

	drop_everything_contained()
	balloon_alert(user, "removed all items")

/// Drops all contents at the mortar
/obj/structure/millstone/proc/drop_everything_contained()
	if(!length(contents))
		return

	for(var/obj/target_item as anything in contents)
		target_item.forceMove(get_turf(src))

/obj/structure/millstone/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	mill_it_up(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/millstone/attackby(obj/item/attacking_item, mob/user)
	if(!((istype(attacking_item, /obj/item/food/grown/)) || (istype(attacking_item, /obj/item/grown))))
		balloon_alert(user, "can only mill plants")
		return ..()

	if(length(contents) >= maximum_contained_items)
		balloon_alert(user, "already full")
		return

	attacking_item.forceMove(src)

/// Takes the content's seeds and spits them out on the turf, as well as grinding whatever the contents may be
/obj/structure/millstone/proc/mill_it_up(mob/living/carbon/human/user)
	if(!length(contents))
		balloon_alert(user, "nothing to mill")
		return

	if(user.getStaminaLoss() > MILLSTONE_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return

	if(!length(contents) || !in_range(src, user))
		return

	balloon_alert_to_viewers("grinding...")

	flick("millstone_spin", src)
	playsound(src, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)

	user.adjustStaminaLoss(MILLSTONE_STAMINA_USE) // Prevents spamming it

	if(!do_after(user, 5 SECONDS, target = src))
		balloon_alert_to_viewers("stopped grinding")
		return

	for(var/target_item as anything in contents)
		seedify(target_item, t_max = 1)

	return

#undef MILLSTONE_STAMINA_MINIMUM
#undef MILLSTONE_STAMINA_USE
