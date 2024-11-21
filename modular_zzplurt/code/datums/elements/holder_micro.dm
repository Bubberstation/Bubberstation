/datum/element/mob_holder/micro

/datum/element/mob_holder/micro/Attach(datum/target, worn_state, alt_worn, right_hand, left_hand, inv_slots = NONE, proctype, escape_on_find)
	. = ..()

	RegisterSignal(target, COMSIG_CLICK_ALT, PROC_REF(mob_try_pickup_micro), TRUE)
	RegisterSignal(target, COMSIG_MICRO_PICKUP_FEET, PROC_REF(mob_pickup_micro_feet))
	RegisterSignal(target, COMSIG_MOB_RESIZED, PROC_REF(on_resize))

/datum/element/mob_holder/micro/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_MICRO_PICKUP_FEET)

/datum/element/mob_holder/micro/proc/on_resize(mob/living/micro, new_size, old_size)
	var/obj/item/clothing/head/mob_holder/holder = micro.loc
	if(istype(holder))
		var/mob/living/living = get_atom_on_turf(micro.loc, /mob/living)
		if(living && (COMPARE_SIZES(living, micro)) < 2.0)
			living.visible_message(span_warning("\The [living] drops [micro] as [micro.p_they()] grow\s too big to carry."),
								span_warning("You drop \The [living] as [living.p_they()] grow\s too big to carry."))
			holder.release()
		else if(!istype(living)) // Somehow a inside a mob_holder and the mob_holder isn't inside any livings? release.
			holder.release()

/datum/element/mob_holder/micro/on_examine(mob/living/source, mob/user, list/examine_list)
	if(ishuman(user) && !istype(source.loc, /obj/item/clothing/head/mob_holder) && (COMPARE_SIZES(user, source)) >= 2.0)
		examine_list += span_notice("Looks like [source.p_they(FALSE)] can be picked up using <b>Alt+Click and grab intent</b>!")

/// Do not inherit from /mob_holder, interactions are different.
/datum/element/mob_holder/micro/on_requesting_context_from_item(
	obj/source,
	list/context,
	obj/item/held_item,
	mob/living/user,
)

	LAZYSET(context, SCREENTIP_CONTEXT_ALT_LMB, "Pick up")
	return CONTEXTUAL_SCREENTIP_SET

/datum/element/mob_holder/micro/proc/mob_pickup_micro(mob/living/source, mob/user)
	var/obj/item/clothing/head/mob_holder/micro/holder = new(get_turf(source), source, worn_state, alt_worn, right_hand, left_hand, inv_slots)
	if(!holder)
		return

	user.put_in_hands(holder)
	return

//shoehorned (get it?) and lazy way to do instant foot pickups cause haha funny.
/datum/element/mob_holder/micro/proc/mob_pickup_micro_feet(mob/living/source, mob/user)
	var/obj/item/clothing/head/mob_holder/micro/holder = new(get_turf(source), source, worn_state, alt_worn, right_hand, left_hand, inv_slots)
	if(!holder)
		return
	user.equip_to_slot(holder, ITEM_SLOT_FEET)
	return

/datum/element/mob_holder/micro/proc/mob_try_pickup_micro(mob/living/carbon/source, mob/living/carbon/user)
	if(!(resolve_intent_name(user.combat_mode) == "grab"))
		return FALSE
	if(!ishuman(user) || !user.Adjacent(source) || user.incapacitated)
		return FALSE
	if(source == user)
		to_chat(user, span_warning("You can't pick yourself up."))
		source.balloon_alert(user, "cannot pick yourself!")
		return FALSE
	if(COMPARE_SIZES(user, source) < 2.0)
		to_chat(user, span_warning("They're too big to pick up!"))
		source.balloon_alert(user, "too big to pick up!")
		return FALSE
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are full!"))
		source.balloon_alert(user, "hands are full!")
		return FALSE
	if(source.buckled)
		to_chat(user, span_warning("[source] is buckled to something!"))
		source.balloon_alert(user, "buckled to something!")
		return FALSE
	source.visible_message(span_warning("[user] starts picking up [source]."), \
					span_userdanger("[user] starts picking you up!"))
	source.balloon_alert(user, "picking up")
	var/time_required = COMPARE_SIZES(source, user) * 4 SECONDS //Scale how fast the pickup will be depending on size difference
	if(!do_after(user, time_required, source))
		return FALSE

	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are full!"))
		source.balloon_alert(user, "hands full!")
		return FALSE
	if(source.buckled)
		to_chat(user, span_warning("[source] is buckled to something!"))
		source.balloon_alert(user, "buckled!")
		return FALSE

	source.visible_message(span_warning("[user] picks up [source]!"),
					span_userdanger("[user] picks you up!"))
	source.drop_all_held_items()
	mob_pickup_micro(source, user)
	return TRUE

/obj/item/clothing/head/mob_holder/micro
	name = "micro"
	desc = "Another person, small enough to fit in your hand."
	icon = null
	icon_state = null
	worn_icon = null
	inhand_icon_state = null
	lefthand_file = null
	righthand_file = null
	slot_flags = ITEM_SLOT_FEET | ITEM_SLOT_HEAD | ITEM_SLOT_ID | ITEM_SLOT_BACK | ITEM_SLOT_NECK
	w_class = null //handled by their size
	item_flags = INEDIBLE_CLOTHING

/obj/item/clothing/head/mob_holder/micro/Initialize(mapload, mob/living/M, worn_state, head_icon, lh_icon, rh_icon, worn_slot_flags)
	. = ..()
	item_flags &= ~ABSTRACT
	//Updating the visuals when the mob updates doesn't work (it disappears)
	//RegisterSignals(held_mob, list(COMSIG_CARBON_APPLY_OVERLAY, COMSIG_CARBON_REMOVE_OVERLAY, COMSIG_ATOM_EXAMINE), PROC_REF(update_visuals))

/obj/item/clothing/head/mob_holder/micro/release(del_on_release, display_messages)
	UnregisterSignal(held_mob, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM))
	return ..()

/obj/item/clothing/head/mob_holder/micro/Destroy()
	UnregisterSignal(src, COMSIG_ATOM_EXAMINE)
	. = ..()

/obj/item/clothing/head/mob_holder/micro/examine(mob/user)
	return held_mob.examine(user)

/obj/item/clothing/head/mob_holder/micro/container_resist_act(mob/living/resisting)
	if(resisting.incapacitated)
		to_chat(resisting, span_warning("You can't escape while you're restrained like this!"))
		return
	var/mob/living/carrier = get_atom_on_turf(src, /mob/living)
	visible_message(span_warning("[resisting] begins to squirm in [carrier]'s grasp!"))
	var/time_required = COMPARE_SIZES(carrier, resisting) / 4 SECONDS //Scale how fast the resisting will be depending on size difference
	if(!do_after(resisting, time_required, carrier, IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM))
		if(!resisting || resisting.stat != CONSCIOUS || resisting.loc != src)
			return
		visible_message(span_warning("[src] stops resisting."))
		return
	visible_message(span_warning("[src] escapes [carrier]!"))
	release()

/obj/item/clothing/head/mob_holder/micro/assume_air(datum/gas_mixture/giver)
	var/turf/location = get_turf(src)
	return location.assume_air(giver)

/obj/item/clothing/head/mob_holder/micro/remove_air(amount)
	var/turf/location = get_turf(src)
	return location.remove_air(amount)

/obj/item/clothing/head/mob_holder/micro/return_air()
	var/turf/location = get_turf(src)
	return location.return_air()

/obj/item/clothing/head/mob_holder/micro/mouse_drop_dragged(atom/M, mob/user, src_location, over_location, params)
	. = ..()
	if(M != usr)
		return
	if(usr == src)
		return
	if(!Adjacent(usr))
		return
	if(istype(M,/mob/living/silicon/ai))
		return
	var/mob/living/carbon/human/O = held_mob
	if(istype(O))
		O.MouseDrop(usr)

/obj/item/clothing/head/mob_holder/micro/attack_self(mob/living/user)
	if(world.time <= user.next_click)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/mob/living/carbon/human/M = held_mob
	if(istype(M))
		switch(resolve_intent_name(user.combat_mode))
			if("harm") //TO:DO, rework all of these interactions to be a lot more in depth
				visible_message(span_danger("[user] slams their fist down on [M]!"))
				playsound(loc, 'sound/items/weapons/punch1.ogg', 50, 1)
				M.adjustBruteLoss(5)
			if("disarm")
				visible_message(span_danger("[user] pins [M] down with a finger!"))
				playsound(loc, 'sound/effects/bodyfall/bodyfall1.ogg', 50, 1)
				M.adjustStaminaLoss(10)
			if("grab")
				visible_message(span_danger("[user] squeezes their fist around [M]!"))
				playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 50, 1)
				M.adjustOxyLoss(5)
			else
				M.help_shake_act(user)

/obj/item/clothing/head/mob_holder/micro/attacked_by(obj/item/I, mob/living/user)
	return held_mob?.attacked_by(I, user) || ..()

/mob/living/Adjacent(atom/neighbor)
	. = ..()
	var/obj/item/clothing/head/mob_holder/micro/micro_holder = loc
	if(istype(micro_holder))
		return micro_holder.Adjacent(neighbor)

/obj/item/clothing/head/mob_holder/micro/attack(mob/living/eater, mob/living/holder)
	var/datum/component/vore/vore = holder.GetComponent(/datum/component/vore)
	if(!vore)
		return ..()

	if(holder == eater) // Parent wants to eat pulled
		vore.vore_other(held_mob)
	else
		vore.feed_other_to_other(eater, held_mob)

/obj/item/clothing/head/mob_holder/micro/Exited(mob/living/totally_not_vored, direction)
	// Transferred to a belly? Get rid of this before it puts us on the floor
	if(istype(totally_not_vored.loc, /obj/vore_belly))
		held_mob = null
		qdel(src)
	return ..()

/obj/item/clothing/head/mob_holder/micro/GetAccess()
	. = ..()
	var/obj/item/held = held_mob.get_active_held_item()
	if(held)
		. += held.GetAccess()
	var/mob/living/carbon/human/human_micro = held_mob
	if(istype(human_micro))
		. += human_micro.wear_id?.GetAccess()

/obj/item/clothing/head/mob_holder/micro/GetID()
	. = ..()
	if(.)
		return
	var/obj/item/held = held_mob.get_active_held_item()
	if(isidcard(held))
		return held
	var/mob/living/carbon/human/human_micro = held_mob
	if(istype(human_micro) && isidcard(human_micro.wear_id))
		return human_micro.wear_id

/obj/item/clothing/head/mob_holder/micro/update_visuals(mob/living/carbon/human/tiny_person)
	. = ..()
	transform = null

// And right here i throw all of those error sprites in the trash
/obj/item/clothing/head/mob_holder/micro/build_worn_icon(default_layer, default_icon_file, isinhands, female_uniform, override_state, override_file, mutant_styles)
	return null
