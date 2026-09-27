/obj/item/breastpump
	name = "breast pump"
	icon = 'modular_zubbers/icons/obj/lewd.dmi'
	icon_state = "breastpump"
	desc = "A breast pump, designed to take beakers or cups to help assist lactating patients."
	w_class = WEIGHT_CLASS_SMALL
	/// Only allowed to input beaker or cup type objects
	var/list/allowed_containers = list(/obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/cup/glass)
	/// The presently-inserted container.
	var/obj/item/reagent_containers/cup/container
	/// Flags used by the injection/draw
	var/inject_flags = NONE
	/// Can you hotswap beakers? - Yes
	var/quickload = TRUE


/obj/item/breastpump/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/breastpump/examine(mob/user)
	. = ..()
	if(container)
		. += "[container] contains [container.reagents.total_volume]u of liquids."
	else
		. += "It has no container loaded in."

/obj/item/breastpump/proc/unload_container(obj/object, mob/user)
	if(!object)
		to_chat(user, span_notice("This container isn't loaded!"))
		return

	container.forceMove(user.loc)
	user.put_in_hands(container)
	to_chat(user, span_notice("You remove [object] from [src]."))
	container = null
	update_icon()
	playsound(loc, 'sound/items/weapons/empty.ogg', 50, 1)

/obj/item/breastpump/proc/insert_container(obj/item/new_container, mob/living/user)
	var/atom/quickswap_loc = new_container.loc
	if(!user.transferItemToLoc(new_container, src))
		return FALSE
	if(!isnull(container))
		if(quickswap_loc == user)
			user.put_in_hands(container)
		else
			container.forceMove(quickswap_loc)
	container = new_container
	user.visible_message(span_notice("[user] has loaded a container into [src]."), span_notice("You have loaded [container] into [src]."))
	playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()

/obj/item/breastpump/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!is_type_in_list(tool, allowed_containers))
		to_chat(user, span_notice("[src] doesn't accept this type of container."))
		return NONE
	if(isnull(container) || quickload)
		insert_container(tool, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src] is only able to hold one container!"))
	return ITEM_INTERACT_BLOCKING

/obj/item/breastpump/proc/try_pump(atom/target, mob/user)
	if(!target.reagents)
		return FALSE

	if(isliving(target))
		var/mob/living/living_target = target
		if(!living_target.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE|inject_flags))
			return FALSE

	return TRUE

/obj/item/breastpump/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!target.reagents)
		return NONE
	if(!src.container)
		to_chat(user, span_warning("No container loaded!"))
		return ITEM_INTERACT_BLOCKING
	if(!try_pump(target, user))
		return ITEM_INTERACT_BLOCKING
	if(target != user)
		to_chat(user, span_warning("You cannot use the breast pump on someone else!"))
		return ITEM_INTERACT_BLOCKING

	SEND_SIGNAL(target, COMSIG_LIVING_TRY_SYRINGE_WITHDRAW, user)

	if(src.container.reagents.holder_full())
		to_chat(user, span_notice("[src] is full."))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/organ/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)

	if (breasts == null)
		to_chat(user, span_notice("[user] does not have compatible breasts."))
		return ITEM_INTERACT_BLOCKING

	if (breasts.reagents.total_volume <= 0)
		to_chat(user, span_notice("[user]'s breasts are empty."))
		return ITEM_INTERACT_BLOCKING

	var/fluid_multiplier = 3

	if(user.has_status_effect(/datum/status_effect/climax))
		fluid_multiplier = 5

	to_chat(user, span_notice("[src] whirs.."))
	var/trans = breasts.reagents.trans_to(src.container, 1 * fluid_multiplier, transferred_by = user) // transfer from, transfer to - who cares?
	if(trans)
		to_chat(user, span_notice("You fill [src.container] with [trans] units of the solution. It now contains [src.container.reagents.total_volume] units."))
	return ITEM_INTERACT_SUCCESS

/obj/item/breastpump/attack_hand(mob/living/user)
	if(user && loc == user && user.is_holding(src))
		if(user.incapacitated)
			return
		else if(!container)
			. = ..()
			return
		else
			unload_container(container,user)
	else
		. = ..()

/obj/item/breastpump/examine(mob/user)
	. = ..()
	. += span_notice("A personal breast pump machine, useable on one's self with a functioning pair of breasts. <b>Left-Click</b> on yourself to use.")


