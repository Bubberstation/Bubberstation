
/datum/component/ball_mittens_fumble
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/struggle_delay_min = 1 SECONDS
	var/struggle_delay_max = 2.5 SECONDS
	var/interact_delay = 1.5 SECONDS
	var/max_item_size = WEIGHT_CLASS_HUGE
	var/is_fumbling = FALSE
	var/is_interacting = FALSE
	var/is_looping = FALSE
	var/cuff_resist_multiplier = 3
	var/pickup_success_chance = 90
	var/gun_spread_penalty = 12
	var/obj/item/tracked_cuffs = null // Tracks modified cuffs so breakouttime is restored safely.

/datum/component/ball_mittens_fumble/Initialize()
	. = ..()
	if(!istype(parent, /obj/item/clothing/gloves/ball_mittens))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(on_pre_unequip))

/// Called by ball_mittens/equipped() after the component is added.
/datum/component/ball_mittens_fumble/proc/register_wearer(mob/living/wearer)
	var/obj/item/clothing/gloves/ball_mittens/mittens = parent
	if(mittens.is_paw_skin && isliving(wearer))
		wearer.add_mood_event("paw_mittens", /datum/mood_event/wearing_paw_mittens)
	if(!mittens.spawn_flavor_shown && mittens.loadout_created)
		mittens.spawn_flavor_shown = TRUE
		INVOKE_ASYNC(mittens, TYPE_PROC_REF(/obj/item/clothing/gloves/ball_mittens, deferred_spawn_flavor), wearer)
	ADD_TRAIT(wearer, TRAIT_GLOVE_SURGERY_PASSTHROUGH, MITTENS_FUMBLE_TRAIT)
	RegisterSignal(wearer, COMSIG_LIVING_TRY_PUT_IN_HAND, PROC_REF(on_try_pickup))
	RegisterSignal(wearer, COMSIG_LIVING_PICKED_UP_ITEM, PROC_REF(on_picked_up))
	RegisterSignal(wearer, COMSIG_MOB_CLICKON, PROC_REF(on_clickon))
	RegisterSignal(wearer, COMSIG_MOB_REMOVING_CUFFS, PROC_REF(on_removing_cuffs))
	RegisterSignal(wearer, COMSIG_MOB_FIRED_GUN, PROC_REF(on_fired_gun))
	RegisterSignal(wearer, COMSIG_TRY_STRIP, PROC_REF(on_try_strip))
	RegisterSignal(wearer, COMSIG_MOUSEDROPPED_ONTO, PROC_REF(on_mousedrop_receive))
	RegisterSignal(wearer, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(wearer, COMSIG_LIVING_RESIST, PROC_REF(on_resist))

/// Called by ball_mittens/dropped() before the component is deleted.
/datum/component/ball_mittens_fumble/proc/unregister_wearer(mob/living/wearer)
	if(!isliving(wearer))
		return
	wearer.clear_mood_event("paw_mittens")
	REMOVE_TRAIT(wearer, TRAIT_GLOVE_SURGERY_PASSTHROUGH, MITTENS_FUMBLE_TRAIT)
	UnregisterSignal(wearer, list(
		COMSIG_LIVING_TRY_PUT_IN_HAND,
		COMSIG_LIVING_PICKED_UP_ITEM,
		COMSIG_MOB_CLICKON,
		COMSIG_MOB_REMOVING_CUFFS,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_TRY_STRIP,
		COMSIG_LIVING_UNARMED_ATTACK,
		COMSIG_LIVING_RESIST,
		COMSIG_MOUSEDROPPED_ONTO,
	))

/datum/component/ball_mittens_fumble/proc/on_pre_unequip(datum/source, force)
	SIGNAL_HANDLER
	if(force)
		return
	var/obj/item/clothing/gloves/ball_mittens/mittens = parent
	var/mob/living/wearer = mittens.loc
	if(!isliving(wearer))
		return
	to_chat(wearer, span_purple("You struggle furiously with [mittens], but you're not even sure if these can come off."))
	return COMPONENT_ITEM_BLOCK_UNEQUIP

/// Returns "paws" for the paw reskin, "chunky mitts" otherwise.
/datum/component/ball_mittens_fumble/proc/get_hand_descriptor(mob/living/wearer)
	if(!iscarbon(wearer))
		return "chunky mitts"
	var/mob/living/carbon/human/human_wearer = wearer
	var/obj/item/clothing/gloves/ball_mittens/mittens = human_wearer.gloves
	if(istype(mittens) && mittens.is_paw_skin)
		return "paws"
	return "chunky mitts"

/// Intercepts clicks to apply mittens fumble behavior before BYOND processes them.
/datum/component/ball_mittens_fumble/proc/on_clickon(mob/living/wearer, atom/target, list/modifiers)
	SIGNAL_HANDLER
	if(is_interacting || is_fumbling)
		return

	if(wearer.throw_mode)
		var/obj/item/held = wearer.get_active_held_item()
		if(!held)
			wearer.throw_mode_off(THROW_MODE_TOGGLE)
			return COMSIG_MOB_CANCEL_CLICKON
		if(prob(5))
			to_chat(wearer, span_purple("You try to grip the [held] with your [get_hand_descriptor(wearer)] to throw it, but it clatters noisily to the floor instead."))
			playsound(wearer, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 30, TRUE)
			wearer.dropItemToGround(held)
			wearer.throw_mode_off(THROW_MODE_TOGGLE)
			return COMSIG_MOB_CANCEL_CLICKON

	if(get_dist(wearer, target) > 1)
		return

	// Retrieve items from pockets, ID slot, suit storage, and ears with a short delay.
	// Belt and back are excluded - intercepting their clicks can break container open/drag behavior.
	// Modifier clicks (shift/alt/ctrl/right) still pass through for pocket items since they
	// open context menus or examine rather than triggering pickup.
	if(isitem(target) && ismob(target.loc) && !is_looping && !wearer.get_active_held_item())
		var/obj/item/slot_item = target
		var/slot = wearer.get_slot_by_item(slot_item)
		if(slot & (ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET|ITEM_SLOT_ID|ITEM_SLOT_SUITSTORE|ITEM_SLOT_EARS|ITEM_SLOT_BELT))
			if(slot_item.atom_storage)
				return
			if(modifiers && (LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, ALT_CLICK) || LAZYACCESS(modifiers, RIGHT_CLICK) || LAZYACCESS(modifiers, CTRL_CLICK)))
				return
			INVOKE_ASYNC(src, PROC_REF(inventory_retrieve), wearer, slot_item)
			return COMSIG_MOB_CANCEL_CLICKON

	if(modifiers && (LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, ALT_CLICK) || LAZYACCESS(modifiers, RIGHT_CLICK) || LAZYACCESS(modifiers, CTRL_CLICK)))
		return

	// Intercept pickup of floor items and items on elevated surfaces (tables, racks, etc).
	if(isitem(target) && (isturf(target.loc) || (isobj(target.loc) && GLOB.typecache_elevated_structures[target.loc.type])) && !(target in wearer.held_items) && !wearer.get_active_held_item())
		var/obj/item/item_target = target
		if(!wearer.held_items.Find(null))
			to_chat(wearer, span_warning("Your [get_hand_descriptor(wearer)] are already occupied. One thing at a time."))
			return COMSIG_MOB_CANCEL_CLICKON
		if(item_target.item_flags & ABSTRACT)
			return
		if(!isgun(item_target) && item_target.w_class >= max_item_size)
			to_chat(wearer, span_warning("You paw at [item_target] futilely. It is far too bulky to manage with these."))
			return COMSIG_MOB_CANCEL_CLICKON
		wearer.face_atom(item_target)
		if(!is_looping)
			INVOKE_ASYNC(src, PROC_REF(fumble_pickup_loop), wearer, item_target)
		return COMSIG_MOB_CANCEL_CLICKON

	// Worn clothing equip/removal - apply a delay then allow.
	if(isclothing(target) && isliving(target.loc) && !wearer.get_active_held_item() && !wearer.combat_mode)
		var/obj/item/clothing/cloth = target
		var/mob/living/living_loc = target.loc
		var/in_hand = (target in wearer.held_items)
		var/truly_worn = (cloth.slot_flags && living_loc.get_item_by_slot(cloth.slot_flags) == cloth)
		if(in_hand || truly_worn)
			if(istype(cloth, /obj/item/clothing/gloves/ball_mittens))
				INVOKE_ASYNC(cloth, TYPE_PROC_REF(/obj/item/clothing/gloves/ball_mittens, doStrip), wearer, wearer)
				return COMSIG_MOB_CANCEL_CLICKON
			INVOKE_ASYNC(src, PROC_REF(clothing_struggle), wearer, target)
			return COMSIG_MOB_CANCEL_CLICKON

	// Machine clicks get a fumble delay before the action fires.
	if(ismachinery(target) && !wearer.combat_mode)
		is_interacting = TRUE
		INVOKE_ASYNC(src, PROC_REF(fumble_interact), wearer, target, modifiers)
		return COMSIG_MOB_CANCEL_CLICKON

/datum/component/ball_mittens_fumble/proc/clothing_struggle(mob/living/wearer, obj/item/clothing/cloth)
	var/delay = 30 SECONDS
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_purple("You struggle to remove [cloth]. It's extremely difficult with your [hand_desc]... (This will take around [DisplayTimeText(delay)] and you need to stand still.)"))
	if(!do_after(wearer, delay, cloth, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(wearer, span_warning("You give up on [cloth]."))
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(cloth))
		return
	wearer.dropItemToGround(cloth)

/datum/component/ball_mittens_fumble/proc/fumble_pickup_loop(mob/living/wearer, obj/item/to_pick_up)
	is_looping = TRUE
	var/hand_desc = get_hand_descriptor(wearer)
	var/on_floor = is_item_on_floor(to_pick_up)
	if(isgun(to_pick_up))
		to_chat(wearer, span_purple("You wedge [to_pick_up] between your [hand_desc]. Are you sure about this..?"))
	else if(on_floor)
		to_chat(wearer, span_purple("You get down on your knees to grab [to_pick_up] with your [hand_desc]."))
	else
		to_chat(wearer, span_purple("You try to grab [to_pick_up] off the surface with your [hand_desc]."))
	var/bystander_msg = on_floor ? \
		"[wearer] gets down on [wearer.p_their()] knees and starts struggling to pick up [to_pick_up] with [wearer.p_their()] [hand_desc]." : \
		"[wearer] starts struggling to grab [to_pick_up] off the surface with [wearer.p_their()] [hand_desc]."
	wearer.visible_message(span_warning(bystander_msg), span_notice("You clumsily fumble at [to_pick_up] with your [hand_desc]..."))

	while(!QDELETED(src) && !QDELETED(wearer) && !QDELETED(to_pick_up))
		if(!pickup_still_valid(wearer, to_pick_up))
			is_looping = FALSE
			return

		var/pick_delay = on_floor ? rand(struggle_delay_min, struggle_delay_max) : rand(0.5 SECONDS, 1.5 SECONDS)
		if(!do_after(wearer, pick_delay, to_pick_up, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_HELD_ITEM | IGNORE_TARGET_LOC_CHANGE, extra_checks = CALLBACK(src, PROC_REF(check_pickup_range), wearer, to_pick_up), interaction_key = "mittens_pickup_[REF(to_pick_up)]"))
			to_chat(wearer, span_warning("You give up on [to_pick_up]."))
			is_looping = FALSE
			return

		if(!pickup_still_valid(wearer, to_pick_up))
			is_looping = FALSE
			return

		if(!prob(pickup_success_chance))
			to_chat(wearer, span_purple("The [to_pick_up] slips right back out of your [hand_desc]! Fuck..."))
			wearer.visible_message(span_warning("[wearer] nearly gets [to_pick_up] between [wearer.p_their()] [hand_desc] and drops it at the last moment."))
			playsound(wearer, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 30, TRUE)
			continue

		playsound(wearer, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 30, TRUE)
		is_fumbling = TRUE
		var/success = wearer.put_in_hands(to_pick_up, forced = TRUE)
		is_fumbling = FALSE
		if(!success)
			is_looping = FALSE
			return
		to_chat(wearer, span_purple("You manage to press [to_pick_up] between your [hand_desc]."))
		is_looping = FALSE
		return

	is_looping = FALSE

/// Returns FALSE if the pickup attempt should be aborted: item was picked up by someone else,
/// out of range, or hands are now full.
/datum/component/ball_mittens_fumble/proc/pickup_still_valid(mob/living/wearer, obj/item/to_pick_up)
	if(ismob(to_pick_up.loc) && !(to_pick_up in wearer.held_items))
		return FALSE
	if(get_dist(wearer, to_pick_up) > 1)
		to_chat(wearer, span_warning("[to_pick_up] is out of reach."))
		return FALSE
	if(!wearer.held_items.Find(null))
		to_chat(wearer, span_warning("Your [get_hand_descriptor(wearer)] are already occupied."))
		return FALSE
	return TRUE

/// Returns TRUE if the item is directly on the floor, FALSE if elevated (table, rack, etc).
/datum/component/ball_mittens_fumble/proc/is_item_on_floor(obj/item/item)
	var/item_loc = item.loc
	if(!isturf(item_loc))
		return FALSE
	var/turf/T = item_loc
	for(var/obj/structure/elevated in T.contents)
		if(GLOB.typecache_elevated_structures[elevated.type])
			return FALSE
	return TRUE

/datum/component/ball_mittens_fumble/proc/check_pickup_range(mob/living/wearer, obj/item/to_pick_up)
	if(QDELETED(wearer) || QDELETED(to_pick_up))
		return FALSE
	return get_dist(wearer, to_pick_up) <= 1

/// Safety net for drag-drop and other bypass paths that skip on_clickon.
/datum/component/ball_mittens_fumble/proc/on_try_pickup(mob/living/wearer, obj/item/to_pick_up)
	SIGNAL_HANDLER
	if(is_fumbling)
		return

	if(to_pick_up.item_flags & ABSTRACT)
		return
	if(!isgun(to_pick_up) && to_pick_up.w_class >= max_item_size)
		to_chat(wearer, span_warning("You paw at [to_pick_up] futilely. It is far too bulky to manage with these."))
		return COMPONENT_LIVING_CANT_PUT_IN_HAND

	if(!wearer.held_items.Find(null))
		to_chat(wearer, span_warning("Your [get_hand_descriptor(wearer)] are already occupied. One thing at a time."))
		return COMPONENT_LIVING_CANT_PUT_IN_HAND

	if(ismob(to_pick_up.loc))
		return

	if(isturf(to_pick_up.loc))
		return COMPONENT_LIVING_CANT_PUT_IN_HAND

/// Adds a short delay when the wearer retrieves an item from a worn inventory slot.
/datum/component/ball_mittens_fumble/proc/inventory_retrieve(mob/living/wearer, obj/item/to_retrieve)
	is_looping = TRUE
	is_fumbling = TRUE
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_purple("You fish around for [to_retrieve] with your [hand_desc]."))
	if(!do_after(wearer, 0.8 SECONDS, to_retrieve, timed_action_flags = IGNORE_HELD_ITEM, interaction_key = "mittens_inv_[REF(to_retrieve)]"))
		to_chat(wearer, span_purple("You are going to have to stop and actually focus on getting out [to_retrieve]!"))
		is_fumbling = FALSE
		is_looping = FALSE
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(to_retrieve))
		is_fumbling = FALSE
		is_looping = FALSE
		return
	if(!ismob(to_retrieve.loc))
		is_fumbling = FALSE
		is_looping = FALSE
		return
	wearer.put_in_hands(to_retrieve)
	is_fumbling = FALSE
	is_looping = FALSE

/datum/component/ball_mittens_fumble/proc/on_picked_up(mob/living/wearer, obj/item/picked_up)
	SIGNAL_HANDLER
	if(is_fumbling)
		return
	if(prob(4))
		INVOKE_ASYNC(src, PROC_REF(drop_excess_storage), wearer, picked_up)

/datum/component/ball_mittens_fumble/proc/drop_excess_storage(mob/living/wearer, obj/item/to_drop)
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(to_drop))
		return
	var/hand_desc = get_hand_descriptor(wearer)
	playsound(wearer, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 30, TRUE)
	to_chat(wearer, span_purple("[to_drop] slips out of your [hand_desc]!"))
	wearer.visible_message(span_warning("[wearer] drops [to_drop] while trying to pull it out with [wearer.p_their()] [hand_desc]."))
	wearer.dropItemToGround(to_drop)

/datum/component/ball_mittens_fumble/proc/on_resist(mob/living/wearer)
	SIGNAL_HANDLER
	var/obj/item/clothing/gloves/ball_mittens/mittens = parent
	if(!istype(mittens))
		return
	if(ishuman(wearer))
		var/mob/living/carbon/human/human_wearer = wearer
		if(human_wearer.handcuffed || human_wearer.legcuffed)
			return
	INVOKE_ASYNC(mittens, TYPE_PROC_REF(/obj/item/clothing/gloves/ball_mittens, doStrip), wearer, wearer)

/datum/component/ball_mittens_fumble/proc/on_unarmed_attack(mob/living/wearer, atom/attack_target, proximity_flag, list/modifiers)
	SIGNAL_HANDLER
	if(!proximity_flag || !isliving(attack_target))
		return
	playsound(wearer, pick('sound/items/toy_squeak/toysqueak1.ogg', 'sound/items/toy_squeak/toysqueak2.ogg', 'sound/items/toy_squeak/toysqueak3.ogg'), 40, TRUE)

/datum/component/ball_mittens_fumble/proc/on_mousedrop_receive(mob/living/wearer, atom/from, mob/user, params)
	SIGNAL_HANDLER
	if(user != wearer || !isitem(from))
		return
	var/obj/item/dragged = from
	var/slot = wearer.get_slot_by_item(dragged)
	if(!(slot & (ITEM_SLOT_BELT|ITEM_SLOT_BACK)))
		return
	is_fumbling = TRUE
	INVOKE_ASYNC(src, PROC_REF(delayed_drag_unequip), wearer, dragged)
	return COMPONENT_CANCEL_MOUSEDROPPED_ONTO

/datum/component/ball_mittens_fumble/proc/delayed_drag_unequip(mob/living/wearer, obj/item/item)
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_purple("You fumble at your [item] with your [hand_desc]..."))
	if(!do_after(wearer, rand(struggle_delay_min, struggle_delay_max), item, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(wearer, span_warning("You give up on [item]."))
		is_fumbling = FALSE
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(item))
		is_fumbling = FALSE
		return
	if(!wearer.get_slot_by_item(item))
		is_fumbling = FALSE
		return
	wearer.put_in_hands(item)
	is_fumbling = FALSE

/datum/component/ball_mittens_fumble/proc/on_try_strip(mob/living/wearer, atom/target, obj/item/item)
	SIGNAL_HANDLER
	if(wearer.get_slot_by_item(item))
		return
	to_chat(wearer, span_purple("You paw at their equipment, but can't seem to manage more than harmlessly bumping your [get_hand_descriptor(wearer)] into them."))
	return COMPONENT_CANT_STRIP

/// Multiplies breakout time for the current cuff escape attempt.
/datum/component/ball_mittens_fumble/proc/on_removing_cuffs(mob/living/wearer, obj/item/cuffs)
	SIGNAL_HANDLER
	if(!cuffs)
		return
	if(cuffs == tracked_cuffs)
		return
	tracked_cuffs = cuffs
	var/original = cuffs.breakouttime
	cuffs.breakouttime = original * cuff_resist_multiplier
	addtimer(CALLBACK(src, PROC_REF(restore_breakouttime), cuffs, original), 1, TIMER_UNIQUE | TIMER_OVERRIDE)

/datum/component/ball_mittens_fumble/proc/restore_breakouttime(obj/item/cuffs, original_time)
	if(QDELETED(cuffs))
		tracked_cuffs = null
		return
	cuffs.breakouttime = original_time
	tracked_cuffs = null

/datum/component/ball_mittens_fumble/proc/on_fired_gun(mob/living/wearer, obj/item/gun/gun, atom/target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER
	if(!isgun(gun) || !islist(bonus_spread_values))
		return
	bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += gun_spread_penalty

/datum/component/ball_mittens_fumble/proc/fumble_interact(mob/living/wearer, atom/target, list/modifiers)
	var/hand_desc = get_hand_descriptor(wearer)
	var/msg
	if(istype(target, /obj/machinery/vending))
		msg = "You awkwardly mash your [hand_desc] against [target]'s selection screen..."
	else
		msg = "You awkwardly paw at [target] with your [hand_desc]..."
	wearer.face_atom(target)
	to_chat(wearer, span_purple(msg))
	wearer.visible_message(span_warning("[wearer] awkwardly paws at [target] with [wearer.p_their()] [hand_desc], visibly struggling to use it."))
	if(!do_after(wearer, interact_delay, target))
		to_chat(wearer, span_warning("You give up on [target]."))
		is_interacting = FALSE
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(target) || get_dist(wearer, target) > 1)
		is_interacting = FALSE
		return
	wearer.ClickOn(target, modifiers)
	is_interacting = FALSE

// ============================================================

/datum/atom_skin/ball_mittens_skin
	abstract_type = /datum/atom_skin/ball_mittens_skin
	greyscale_item_path = /obj/item/clothing/gloves/ball_mittens/loadout_paw

/datum/atom_skin/ball_mittens_skin/default
	preview_name = "Ball Mittens"
	reset_missing = TRUE

/datum/atom_skin/ball_mittens_skin/cat_paws
	preview_name = "Cat Paws"
	new_name = "latex paw mittens"
	new_desc = "A pair of inflatable latex mittens shaped like rounded paws. Helpless AND humiliating."
	change_worn_icon_state = FALSE
	greyscale_item_path = null
	new_icon = 'icons/map_icons/clothing/_clothing.dmi'
	new_icon_state = "/obj/item/clothing/gloves/ball_mittens/loadout_paw"
	new_worn_icon = 'modular_skyrat/modules/GAGS/icons/catglove_worn.dmi'

/datum/atom_skin/ball_mittens_skin/cat_paws/get_preview_icon(atom/for_atom)
	return image(icon = 'icons/map_icons/clothing/_clothing.dmi', icon_state = "/obj/item/clothing/gloves/ball_mittens/loadout_paw")

/datum/atom_skin/ball_mittens_skin/cat_paws/apply(atom/apply_to, mob/user)
	var/obj/item/clothing/gloves/ball_mittens/mittens = apply_to
	if(istype(mittens))
		mittens.greyscale_config = /datum/greyscale_config/catgloves
		mittens.greyscale_config_worn = /datum/greyscale_config/catgloves/worn
		if(!mittens.greyscale_colors || mittens.greyscale_colors == "")
			mittens.greyscale_colors = "#242329#7B48A6#15B1BF"
		mittens.flags_1 |= IS_PLAYER_COLORABLE_1
	. = ..()
	if(istype(mittens))
		mittens.is_paw_skin = TRUE
		mittens.worn_icon = 'modular_skyrat/modules/GAGS/icons/catglove_worn.dmi'
		mittens.icon_state = "catgloves"
		mittens.worn_icon_state = "catgloves"
		mittens.set_greyscale(mittens.greyscale_colors, /datum/greyscale_config/catgloves)

/datum/atom_skin/ball_mittens_skin/cat_paws/clear_skin(atom/clear_from)
	var/obj/item/clothing/gloves/ball_mittens/mittens = clear_from
	if(istype(mittens))
		mittens.is_paw_skin = FALSE
		mittens.greyscale_config = null
		mittens.greyscale_config_worn = null
		mittens.flags_1 &= ~IS_PLAYER_COLORABLE_1
		mittens.icon_state = initial(mittens.icon_state)
		mittens.worn_icon_state = initial(mittens.worn_icon_state)
		mittens.worn_icon = initial(mittens.worn_icon)
	. = ..()
	if(istype(mittens))
		mittens.update_appearance()

// ============================================================

/obj/item/clothing/gloves/ball_mittens
	name = "ball mittens"
	desc = "A pair of inflatable latex mittens. Adorable and comfortable, but completely useless for anything requiring fingers. You'll need someone else to get these off."
	icon_state = "ballmittens"
	inhand_icon_state = "" // Explicitly empty - null can cause BYOND to fall back to the main icon
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
	strip_delay = 8 SECONDS
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/ball_mittens
	equip_sound = 'modular_zubbers/sound/lewd/rubber1.ogg'
	drop_sound = 'modular_zubbers/sound/lewd/rubber2.ogg'
	pickup_sound = 'modular_zubbers/sound/lewd/rubber3.ogg'
	var/is_paw_skin = FALSE
	var/spawn_flavor_shown = FALSE
	var/loadout_created = FALSE

/obj/item/clothing/gloves/ball_mittens/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_GLOVES)
		return
	if(is_paw_skin)
		to_chat(user, span_purple("The [src] seal around your hands. You pull at them and find it completely impossible to remove them..."))
	else
		to_chat(user, span_purple("Your hands sink into [src]. Soft, round, and not particularly good at anything. As soon as you put them on, you hear them self inflate. Oh shit..."))
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))
	var/datum/component/ball_mittens_fumble/comp = AddComponent(/datum/component/ball_mittens_fumble)
	comp.register_wearer(user)

/obj/item/clothing/gloves/ball_mittens/dropped(mob/user)
	. = ..()
	UnregisterSignal(src, COMSIG_OBJ_RESKIN)
	var/datum/component/ball_mittens_fumble/comp = GetComponent(/datum/component/ball_mittens_fumble)
	comp?.unregister_wearer(user)
	qdel(comp)

/obj/item/clothing/gloves/ball_mittens/proc/on_reskin(datum/source, skin_name)
	SIGNAL_HANDLER
	is_paw_skin = (skin_name == "Cat Paws")
	var/mob/living/wearer = loc
	if(!isliving(wearer))
		return
	if(is_paw_skin)
		wearer.add_mood_event("paw_mittens", /datum/mood_event/wearing_paw_mittens)
		to_chat(wearer, span_purple("The nanite-infused rubber shifts your hands into soft, rounded paw shapes."))
	else
		wearer.clear_mood_event("paw_mittens")
		to_chat(wearer, span_purple("The mittens ease back into their round ball shape. Still completely useless."))

/// Opens the GAGS recolor menu for spray can use on paw mittens.
/// gags_recolorable.open_ui() uses initial() on greyscale_config which returns null
/// for runtime-assigned configs, so we open the menu with the live config directly.
/obj/item/clothing/gloves/ball_mittens/proc/paw_spray_interact(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/crayon/spraycan))
		return NONE
	var/obj/item/toy/crayon/spraycan/can = tool
	if(can.is_capped)
		user.balloon_alert(user, "take the cap off first!")
		return ITEM_INTERACT_BLOCKING
	if(can.check_empty())
		user.balloon_alert(user, "empty!")
		return ITEM_INTERACT_BLOCKING
	if(!user.client)
		return ITEM_INTERACT_BLOCKING
	var/list/allowed = list("[/datum/greyscale_config/catgloves]", "[/datum/greyscale_config/catgloves/worn]")
	var/datum/greyscale_modify_menu/spray_paint/menu = new(
		src, user.client, allowed,
		CALLBACK(src, PROC_REF(apply_spray_colors), can),
		"catgloves",
		/datum/greyscale_config/catgloves,
		greyscale_colors,
		can,
	)
	menu.ui_interact(user)
	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/gloves/ball_mittens/proc/apply_spray_colors(obj/item/toy/crayon/spraycan/can, datum/greyscale_modify_menu/menu)
	if(QDELETED(src) || QDELETED(can) || QDELETED(menu))
		return
	if(can.is_capped || can.check_empty())
		menu.ui_close()
		return
	can.use_charges()
	if(can.pre_noise)
		audible_message(span_hear("You hear spraying."))
		playsound(loc, 'sound/effects/spray.ogg', 50, TRUE, 5)
	set_greyscale(menu.split_colors)

/obj/item/clothing/gloves/ball_mittens/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_paw_skin && istype(tool, /obj/item/toy/crayon/spraycan))
		return paw_spray_interact(user, tool, modifiers)
	return ..()

/obj/item/clothing/gloves/ball_mittens/proc/deferred_spawn_flavor(mob/user)
	if(user.client)
		show_spawn_flavor(user)
		return
	RegisterSignal(user, COMSIG_MOB_LOGIN, PROC_REF(on_client_login_flavor))

/obj/item/clothing/gloves/ball_mittens/proc/on_client_login_flavor(mob/user)
	SIGNAL_HANDLER
	UnregisterSignal(user, COMSIG_MOB_LOGIN)
	show_spawn_flavor(user)

/datum/armor/ball_mittens
	bio = 1

/obj/item/clothing/gloves/ball_mittens/proc/show_spawn_flavor(mob/user)
	if(!user?.client)
		return
	if(is_paw_skin)
		to_chat(user, span_purple("You look down at your paws. Round and soft and utterly useless. You blush as you think about how difficult this is going to make your day at work."))
	else
		to_chat(user, span_purple("You look down at [src]. Why did I come to work like this?"))

/obj/item/clothing/gloves/ball_mittens/attackby(obj/item/item, mob/living/user, params)
	if(!istype(item, /obj/item/clothing/gloves/color/yellow))
		return ..()
	if(siemens_coefficient == 0)
		to_chat(user, span_warning("[src] are already insulated."))
		return
	user.visible_message(
		span_notice("[user] holds [item] up to [src] with a look of intense concentration, then discards it with a sigh."),
		span_notice("You press [item] against [src], attempting to combine them. Halfway through you realize latex is, in fact, already an insulator. You throw away the insulated gloves.")
	)
	siemens_coefficient = 0
	name = is_paw_skin ? "insulated latex paw mittens" : "insulated ball mittens"
	desc = "A pair of inflatable latex mittens. Someone has helpfully applied insulated gloves to them, only to realise too late that latex was already an insulator."
	qdel(item)
	update_appearance()
	return TRUE

/obj/item/clothing/gloves/ball_mittens/doStrip(mob/stripper, mob/owner)
	if(stripper == owner)
		var/delay = 1 MINUTES
		to_chat(owner, span_purple("You attempt to remove [src]... (This will take around [DisplayTimeText(delay)] and you need to stand still.)"))
		to_chat(owner, span_purple("You struggle furiously with [src], but you're not even sure if these can come off."))
		playsound(owner, pick('modular_zubbers/sound/lewd/rubber1.ogg', 'modular_zubbers/sound/lewd/rubber2.ogg', 'modular_zubbers/sound/lewd/rubber3.ogg'), 40, TRUE)
		if(!do_after(owner, delay, src, timed_action_flags = IGNORE_HELD_ITEM))
			to_chat(owner, span_purple("You give up trying to escape [src]. Maybe having [src] isn't so bad..."))
			return FALSE
		if(QDELETED(src) || !isliving(loc))
			return FALSE
	if(!owner.dropItemToGround(src, force = TRUE))
		return FALSE
	if(HAS_TRAIT(stripper, TRAIT_STICKY_FINGERS))
		stripper.put_in_hands(src)
	return TRUE

// ============================================================
// Loadout subtype for paw mittens.
// ============================================================

/obj/item/clothing/gloves/ball_mittens/loadout_paw
	name = "latex paw mittens"
	desc = "A pair of inflatable latex mittens shaped like rounded paws. Helpless AND humiliating."
	greyscale_config = /datum/greyscale_config/catgloves
	greyscale_config_worn = /datum/greyscale_config/catgloves/worn
	greyscale_colors = "#242329#7B48A6#15B1BF"
	flags_1 = IS_PLAYER_COLORABLE_1
	worn_icon = 'modular_skyrat/modules/GAGS/icons/catglove_worn.dmi'
	worn_icon_state = "catgloves"
	icon_state = "BasePaws"
	post_init_icon_state = "catgloves"
	icon_preview = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state_preview = "/obj/item/clothing/gloves/ball_mittens/loadout_paw"
	is_paw_skin = TRUE
	inhand_icon_state = "greyscale_gloves"

/obj/item/clothing/gloves/ball_mittens/loadout_paw/Initialize(mapload)
	. = ..()
	loadout_created = TRUE
	for(var/datum/component/reskinable_item/reskin_comp in GetComponents(/datum/component/reskinable_item))
		qdel(reskin_comp)
	if(SSgreyscale?.initialized)
		icon_state = "catgloves"
		update_greyscale()

/obj/item/clothing/gloves/ball_mittens/loadout_paw/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_GLOVES)
		return
	icon_state = "catgloves"
	worn_icon_state = "catgloves"
	set_greyscale(greyscale_colors, /datum/greyscale_config/catgloves)

// ============================================================

/datum/mood_event/wearing_paw_mittens
	description = span_purple("So-ft... Ro-und... Use-less... Lo-ve it!\n")

/obj/item/clothing/gloves/latex_gloves
	name = "latex gloves"
	desc = "Awesome looking gloves that are satisfying to the touch."
	icon_state = "latexgloves"
	inhand_icon_state = "latex_gloves"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
