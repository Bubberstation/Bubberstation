/obj/item/breastpump
	name = "breast pump"
	icon = 'modular_zubbers/icons/obj/lewd.dmi'
	icon_state = "breastpump"
	desc = "A breast pump, designed to take beakers to help assist lactating patients."
	w_class = WEIGHT_CLASS_SMALL
	/// Only allowed to input beaker type objects
	var/list/allowed_containers = list(/obj/item/reagent_containers/cup/beaker)
	/// The presently-inserted beaker.
	var/obj/item/reagent_containers/cup/beaker/beaker
	/// Flags used by the injection/draw
	var/inject_flags = NONE
	/// Can you hotswap beakers? - Yes
	var/quickload = TRUE
	/// Does it penetrate clothing? - We probably want it to be used with clothing
	var/penetrates = null


/obj/item/breastpump/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/breastpump/examine(mob/user)
	. = ..()
	if(beaker)
		. += "[beaker] contains [beaker.reagents.total_volume]u of liquids."
	else
		. += "It has no beaker loaded in."

/obj/item/breastpump/proc/unload_beaker(obj/object, mob/user)
	if((istype(object, /obj/item/reagent_containers/cup/beaker)))
		var/obj/item/reagent_containers/cup/beaker/container = object
		container.forceMove(user.loc)
		user.put_in_hands(container)
		to_chat(user, span_notice("You remove [object] from [src]."))
		beaker = null
		update_icon()
		playsound(loc, 'sound/items/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, span_notice("This beaker isn't loaded!"))
		return

/obj/item/breastpump/proc/insert_beaker(obj/item/new_beaker, mob/living/user)
	if(!is_type_in_list(new_beaker, allowed_containers))
		to_chat(user, span_notice("[src] doesn't accept this type of beaker."))
		return FALSE
	var/atom/quickswap_loc = new_beaker.loc
	if(!user.transferItemToLoc(new_beaker, src))
		return FALSE
	if(!isnull(beaker))
		if(quickswap_loc == user)
			user.put_in_hands(beaker)
		else
			beaker.forceMove(quickswap_loc)
	beaker = new_beaker
	user.visible_message(span_notice("[user] has loaded a beaker into [src]."), span_notice("You have loaded [beaker] into [src]."))
	playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()

/obj/item/breastpump/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/reagent_containers/cup/beaker))
		return NONE
	if(isnull(beaker) || quickload)
		insert_beaker(tool, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src] is only able to hold one beaker!"))
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
	if(!src.beaker)
		to_chat(user, span_warning("No beaker loaded!"))
		return ITEM_INTERACT_BLOCKING
	if(!try_pump(target, user))
		return ITEM_INTERACT_BLOCKING
	if(target != user)
		to_chat(user, span_warning("You cannot use the breast pump on someone else!"))
		return ITEM_INTERACT_BLOCKING

	SEND_SIGNAL(target, COMSIG_LIVING_TRY_SYRINGE_WITHDRAW, user)

	if(src.beaker.reagents.holder_full())
		to_chat(user, span_notice("[src] is full."))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/organ/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)

	if (breasts == null)
		to_chat(user, span_notice("[user]'s does not have compatible breasts."))
		return ITEM_INTERACT_BLOCKING

	if (breasts.reagents.total_volume <= 0)
		to_chat(user, span_notice("[user]'s breast's are empty."))
		return ITEM_INTERACT_BLOCKING

	var/fluid_multiplier = 3

	if(user.has_status_effect(/datum/status_effect/climax))
		fluid_multiplier = 5

	to_chat(user, span_notice("[src] whirs.."))
	var/trans = breasts.reagents.trans_to(src.beaker, 1 * fluid_multiplier, transferred_by = user) // transfer from, transfer to - who cares?
	if(trans)
		to_chat(user, span_notice("You fill [src.beaker] with [trans] units of the solution. It now contains [src.beaker.reagents.total_volume] units."))
	return ITEM_INTERACT_SUCCESS

/obj/item/breastpump/attack_hand(mob/living/user)
	if(user && loc == user && user.is_holding(src))
		if(user.incapacitated)
			return
		else if(!beaker)
			. = ..()
			return
		else
			unload_beaker(beaker,user)
	else
		. = ..()

/obj/item/breastpump/examine(mob/user)
	. = ..()
	. += span_notice("A personal breast pump machine, useable on one's self with a functioning pair of breasts. <b>Left-Click</b> on yourself to use.")


