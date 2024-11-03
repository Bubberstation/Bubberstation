/datum/element/mob_holder
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2
	var/worn_state
	var/alt_worn
	var/right_hand
	var/left_hand
	var/inv_slots
	var/proctype //if present, will be invoked on headwear generation.

/datum/element/mob_holder/Attach(datum/target, worn_state, alt_worn, right_hand, left_hand, inv_slots = NONE, proctype)
	. = ..()

	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE

	src.worn_state = worn_state
	src.alt_worn = alt_worn
	src.right_hand = right_hand
	src.left_hand = left_hand
	src.inv_slots = inv_slots
	src.proctype = proctype

	RegisterSignal(target, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM, PROC_REF(on_requesting_context_from_item))
	RegisterSignal(target, COMSIG_CLICK_ALT, PROC_REF(mob_try_pickup))
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/mob_holder/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, list(COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM, COMSIG_CLICK_ALT, COMSIG_ATOM_EXAMINE))

/datum/element/mob_holder/proc/on_examine(mob/living/source, mob/user, list/examine_list)
	if(ishuman(user) && !istype(source.loc, /obj/item/clothing/head/mob_holder))
		examine_list += span_notice("Looks like [source.p_they(FALSE)] can be picked up with <b>Alt+Click</b>!")

/datum/element/mob_holder/proc/on_requesting_context_from_item(
	obj/source,
	list/context,
	obj/item/held_item,
	mob/living/user,
)
	SIGNAL_HANDLER

	if(ishuman(user))
		LAZYSET(context, SCREENTIP_CONTEXT_ALT_LMB, "Pick up")
		return CONTEXTUAL_SCREENTIP_SET

/datum/element/mob_holder/proc/mob_try_pickup(mob/living/source, mob/user)
	if(!ishuman(user) || !user.Adjacent(source) || user.incapacitated)
		return FALSE
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are full!"))
		return FALSE
	if(source.buckled)
		to_chat(user, span_warning("[source] is buckled to something!"))
		return FALSE
	if(source == user)
		to_chat(user, span_warning("You can't pick yourself up."))
		return FALSE
	source.visible_message(span_warning("[user] starts picking up [source]."), \
					span_userdanger("[user] starts picking you up!"))
	if(!do_after(user, 2 SECONDS, target = source) || source.buckled)
		return FALSE

	source.visible_message(span_warning("[user] picks up [source]!"), \
					span_userdanger("[user] picks you up!"))
	to_chat(user, span_notice("You pick [source] up."))
	source.drop_all_held_items()
	var/obj/item/clothing/head/mob_holder/holder = new(get_turf(source), source, worn_state, alt_worn, right_hand, left_hand, inv_slots)

	if(proctype)
		INVOKE_ASYNC(src, proctype, source, holder, user)
	user.put_in_hands(holder)
	return TRUE

/datum/element/mob_holder/proc/drone_worn_icon(mob/living/basic/drone/D, obj/item/clothing/head/mob_holder/holder, mob/user)
	var/new_state = "[D.visualAppearance]_hat"
	holder.inhand_icon_state = new_state
	holder.icon_state = new_state
