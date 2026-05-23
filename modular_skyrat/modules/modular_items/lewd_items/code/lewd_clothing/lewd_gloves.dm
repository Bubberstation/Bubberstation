// BUBBER EDIT ADDITION START - ball mittens rework
// Component defined here to avoid DME changes.

/datum/component/ball_mittens_fumble
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/struggle_delay_min = 10
	var/struggle_delay_max = 25
	var/interact_delay = 15
	var/max_item_size = WEIGHT_CLASS_NORMAL
	var/max_fumble_range = 1
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

/// Called by ball_mittens/equipped() after the component is added.
/datum/component/ball_mittens_fumble/proc/register_wearer(mob/living/wearer)
	// Spawn flavor only on loadout equip, not manual equip
	var/obj/item/clothing/gloves/ball_mittens/mittens = parent
	// Paw moodlet - applies whenever paw skin is active regardless of how they were equipped
	if(mittens.is_paw_skin && isliving(wearer))
		wearer.add_mood_event("paw_mittens", /datum/mood_event/wearing_paw_mittens)
	if(!mittens.spawn_flavor_shown && mittens.loadout_created)
		mittens.spawn_flavor_shown = TRUE
		INVOKE_ASYNC(mittens, TYPE_PROC_REF(/obj/item/clothing/gloves/ball_mittens, deferred_spawn_flavor), wearer)
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

/// Returns "paws" for the paw reskin, "chunky mitts" otherwise.
/datum/component/ball_mittens_fumble/proc/get_hand_descriptor(mob/living/wearer)
	if(!iscarbon(wearer))
		return "chunky mitts"
	var/mob/living/carbon/human/H = wearer
	var/obj/item/clothing/gloves/ball_mittens/G = H.gloves
	if(istype(G) && G.is_paw_skin)
		return "paws"
	return "chunky mitts"

/// Intercepts clicks to apply mittens fumble behavior before BYOND processes them.
/datum/component/ball_mittens_fumble/proc/on_clickon(mob/living/wearer, atom/target, list/modifiers)
	SIGNAL_HANDLER
	if(is_interacting || is_fumbling)
		return
	if(modifiers && (LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, ALT_CLICK) || LAZYACCESS(modifiers, RIGHT_CLICK) || LAZYACCESS(modifiers, CTRL_CLICK)))
		return

	if(wearer.throw_mode)
		var/obj/item/held = wearer.get_active_held_item()
		if(!held)
			wearer.throw_mode_off(THROW_MODE_TOGGLE)
			return COMSIG_MOB_CANCEL_CLICKON
		// 5% chance to fumble the throw - item drops instead of flying
		if(prob(5))
			to_chat(wearer, span_purple("You try to grip the [held.name] with your [get_hand_descriptor(wearer)] to throw it, but it clatters noisily to the floor instead."))
			playsound(wearer, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 30, TRUE)
			wearer.dropItemToGround(held)
			wearer.throw_mode_off(THROW_MODE_TOGGLE)
			return COMSIG_MOB_CANCEL_CLICKON
		// 95% of the time throw proceeds normally - throw_mode_off happens naturally after throw

	if(get_dist(wearer, target) > max_fumble_range)
		return

	// Retrieve items from pockets, ID slot, suit storage, and ears with a short delay.
	// Belt and back are excluded - intercepting their clicks can break container open/drag behavior.
	if(isitem(target) && ismob(target.loc) && !is_looping && !wearer.get_active_held_item())
		var/obj/item/slot_item = target
		var/slot = wearer.get_slot_by_item(slot_item)
		// Belt and back are excluded because intercepting their click breaks
		// the container-open and click-drag-to-remove behavior.
		if(slot & (ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET|ITEM_SLOT_ID|ITEM_SLOT_SUITSTORE|ITEM_SLOT_EARS|ITEM_SLOT_BELT))
			// Containers open on click rather than retrieving to hand; pass through
			if(slot_item.atom_storage)
				return
			INVOKE_ASYNC(src, PROC_REF(inventory_retrieve), wearer, slot_item)
			return COMSIG_MOB_CANCEL_CLICKON

	// Intercept pickup of floor items and items on elevated surfaces (tables, racks, etc).
	// Uses the same typecache as the food degradation/ant system to distinguish surfaces from containers.
	// Items inside bags have a non-elevated obj as loc and are intentionally excluded.
	if(isitem(target) && (isturf(target.loc) || (istype(target.loc, /atom/movable) && GLOB.typecache_elevated_structures[target.loc.type])) && !(target in wearer.held_items) && !wearer.get_active_held_item())
		var/obj/item/item_target = target
		var/held_count = 0
		for(var/obj/item/held in wearer.held_items)
			if(!isnull(held))
				held_count++
		if(held_count >= 1)
			to_chat(wearer, span_warning("Your [get_hand_descriptor(wearer)] are already occupied. One thing at a time."))
			return COMSIG_MOB_CANCEL_CLICKON
		if(item_target.item_flags & ABSTRACT)
			return // Abstract items like riding_offhand are internal - pass through.
		if(!isgun(item_target) && item_target.w_class >= WEIGHT_CLASS_HUGE)
			to_chat(wearer, span_warning("You paw at [item_target] futilely. It is far too bulky to manage with these."))
			return COMSIG_MOB_CANCEL_CLICKON
		wearer.face_atom(item_target)
		if(!is_looping)
			INVOKE_ASYNC(src, PROC_REF(fumble_pickup_loop), wearer, item_target)
		return COMSIG_MOB_CANCEL_CLICKON

	// Worn clothing equip/removal - apply a delay then allow.
	// Longer than the catsuit delay but shorter than cuff escape.
	if(istype(target, /obj/item/clothing) && isliving(target.loc) && !wearer.get_active_held_item() && !wearer.combat_mode)
		var/obj/item/clothing/cloth = target
		var/mob/living/L = target.loc
		var/in_hand = (target in wearer.held_items)
		var/truly_worn = (cloth.slot_flags && L.get_item_by_slot(cloth.slot_flags) == cloth)
		if(in_hand || truly_worn)
			if(istype(cloth, /obj/item/clothing/gloves/ball_mittens))
				INVOKE_ASYNC(cloth, TYPE_PROC_REF(/obj/item/clothing/gloves/ball_mittens, doStrip), wearer, wearer)
				return COMSIG_MOB_CANCEL_CLICKON
			INVOKE_ASYNC(src, PROC_REF(clothing_struggle), wearer, target)
			return COMSIG_MOB_CANCEL_CLICKON

	// Machine clicks get a fumble delay before the action fires.
	// Skip in combat mode - the wearer is attacking the machine, not interfacing with it.
	if(istype(target, /obj/machinery) && !wearer.combat_mode)
		is_interacting = TRUE // Set before INVOKE_ASYNC to prevent double-queuing
		INVOKE_ASYNC(src, PROC_REF(fumble_interact), wearer, target, modifiers)
		return COMSIG_MOB_CANCEL_CLICKON

/// Runs the item pickup fumble loop. Item stays in place because on_clickon intercepted the original click.
/datum/component/ball_mittens_fumble/proc/clothing_struggle(mob/living/wearer, obj/item/clothing/cloth)
	var/delay = 300 // 30 seconds
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_purple("You struggle to remove [cloth]. It's extremely difficult with your [hand_desc]... (This will take around [DisplayTimeText(delay)] and you need to stand still.)"))
	if(!do_after(wearer, delay, cloth, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(wearer, span_warning("You give up on [cloth]."))
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(cloth))
		return
	// Use the component's fumbling flag so the click doesn't re-trigger this proc
	is_fumbling = TRUE
	wearer.ClickOn(cloth)
	is_fumbling = FALSE

/datum/component/ball_mittens_fumble/proc/fumble_pickup_loop(mob/living/wearer, obj/item/to_pick_up)
	is_looping = TRUE
	var/hand_desc = get_hand_descriptor(wearer)
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(to_pick_up))
		is_looping = FALSE
		return
	var/on_floor = is_item_on_floor(to_pick_up)
	if(isgun(to_pick_up))
		to_chat(wearer, span_purple("You wedge [to_pick_up] between your [hand_desc]. Are you sure about this..?"))
	else if(on_floor)
		to_chat(wearer, span_purple("You get down on your knees to grab [to_pick_up] with your [hand_desc]."))
	else
		to_chat(wearer, span_purple("You try to grab [to_pick_up] off the surface with your [hand_desc]."))
	var/bystander_msg = on_floor ? 		"[wearer] gets down on [wearer.p_their()] knees and starts struggling to pick up [to_pick_up] with [wearer.p_their()] [hand_desc]." : 		"[wearer] starts struggling to grab [to_pick_up] off the surface with [wearer.p_their()] [hand_desc]."
	wearer.visible_message(span_warning(bystander_msg), span_notice("You clumsily fumble at [to_pick_up] with your [hand_desc]..."))

	while(TRUE)
		if(QDELETED(src) || QDELETED(wearer) || QDELETED(to_pick_up))
			is_looping = FALSE
			return
		if(ismob(to_pick_up.loc) && !(to_pick_up in wearer.held_items))
			is_looping = FALSE
			return
		if(get_dist(wearer, to_pick_up) > max_fumble_range)
			to_chat(wearer, span_warning("[to_pick_up] is out of reach."))
			is_looping = FALSE
			return
		var/held_count = 0
		for(var/obj/item/held in wearer.held_items)
			if(!isnull(held))
				held_count++
		if(held_count >= 1)
			to_chat(wearer, span_warning("Your [hand_desc] are already occupied."))
			is_looping = FALSE
			return

		var/pick_delay = on_floor ? rand(struggle_delay_min, struggle_delay_max) : rand(5, 15)
		if(!do_after(wearer, pick_delay, to_pick_up, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_HELD_ITEM | IGNORE_TARGET_LOC_CHANGE, extra_checks = CALLBACK(src, PROC_REF(check_pickup_range), wearer, to_pick_up), interaction_key = "mittens_pickup_[REF(to_pick_up)]"))
			to_chat(wearer, span_warning("You give up on [to_pick_up]."))
			is_looping = FALSE
			return

		if(QDELETED(src) || QDELETED(wearer) || QDELETED(to_pick_up))
			is_looping = FALSE
			return
		if(ismob(to_pick_up.loc) && !(to_pick_up in wearer.held_items))
			is_looping = FALSE
			return
		held_count = 0
		for(var/obj/item/held in wearer.held_items)
			if(!isnull(held))
				held_count++
		if(held_count >= 1)
			to_chat(wearer, span_warning("Your [hand_desc] filled up while you were working at it."))
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


/// Returns TRUE if the item is on the floor, FALSE if it is on an elevated surface (table, rack, etc).
/// Items on tables still have loc=turf, so we check turf contents against typecache_elevated_structures.
/datum/component/ball_mittens_fumble/proc/is_item_on_floor(obj/item/item)
	if(!isturf(item.loc))
		return FALSE // In a container - not a floor item
	var/turf/T = item.loc
	for(var/atom/movable/AM in T.contents)
		if(GLOB.typecache_elevated_structures[AM.type])
			return FALSE // Shares turf with a table/rack - treat as elevated
	return TRUE

/datum/component/ball_mittens_fumble/proc/check_pickup_range(mob/living/wearer, obj/item/to_pick_up)
	if(QDELETED(wearer) || QDELETED(to_pick_up))
		return FALSE
	return get_dist(wearer, to_pick_up) <= max_fumble_range

/// Safety net for drag-drop and other bypass paths that skip on_clickon.
/datum/component/ball_mittens_fumble/proc/on_try_pickup(mob/living/wearer, obj/item/to_pick_up)
	SIGNAL_HANDLER
	if(is_fumbling)
		return

	if(to_pick_up.item_flags & ABSTRACT)
		return // Abstract/virtual items bypass all mittens restrictions
	if(!isgun(to_pick_up) && to_pick_up.w_class >= WEIGHT_CLASS_HUGE)
		to_chat(wearer, span_warning("You paw at [to_pick_up] futilely. It is far too bulky to manage with these."))
		return COMPONENT_LIVING_CANT_PUT_IN_HAND

	var/hand_desc = get_hand_descriptor(wearer)
	var/held_count = 0
	for(var/obj/item/held in wearer.held_items)
		if(!isnull(held))
			held_count++
	if(held_count >= 1)
		to_chat(wearer, span_warning("Your [hand_desc] are already occupied. One thing at a time."))
		return COMPONENT_LIVING_CANT_PUT_IN_HAND

	// Items in inventory slots (pocket, belt, ID) pass through - on_picked_up handles fumble chance.
	// Blocking put_in_hands here causes silent floor drops via put_in_hands failure fallback.
	if(ismob(to_pick_up.loc))
		return

	if(isturf(to_pick_up.loc))
		return COMPONENT_LIVING_CANT_PUT_IN_HAND

/// Adds a short delay when the wearer retrieves an item from a worn inventory slot.
/datum/component/ball_mittens_fumble/proc/inventory_retrieve(mob/living/wearer, obj/item/to_retrieve)
	is_looping = TRUE
	is_fumbling = TRUE // Blocks concurrent pickup attempts (e.g. alt-click during the delay)
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
	if(!ismob(to_retrieve.loc)) // item moved during delay
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

/// Plays a toy squeak when the wearer punches a living mob bare-handed.
/datum/component/ball_mittens_fumble/proc/on_resist(mob/living/wearer)
	SIGNAL_HANDLER
	var/obj/item/clothing/gloves/ball_mittens/mittens = parent
	if(!istype(mittens) || wearer.handcuffed || wearer.legcuffed)
		return // Cuffed: let normal cuff-resist run
	INVOKE_ASYNC(mittens, TYPE_PROC_REF(/obj/item/clothing/gloves/ball_mittens, doStrip), wearer, wearer)

/datum/component/ball_mittens_fumble/proc/on_unarmed_attack(mob/living/wearer, atom/attack_target, proximity_flag, list/modifiers)
	SIGNAL_HANDLER
	if(!proximity_flag || !isliving(attack_target))
		return // Only squeak when actually punching a living mob in melee
	playsound(wearer, pick('sound/items/toy_squeak/toysqueak1.ogg', 'sound/items/toy_squeak/toysqueak2.ogg', 'sound/items/toy_squeak/toysqueak3.ogg'), 40, TRUE)

/datum/component/ball_mittens_fumble/proc/on_mousedrop_receive(mob/living/wearer, atom/from, mob/user, params)
	SIGNAL_HANDLER
	// Only intercept when the wearer is dragging their own belt or backpack to hand
	if(user != wearer || !isitem(from))
		return
	var/obj/item/dragged = from
	var/slot = wearer.get_slot_by_item(dragged)
	if(!(slot & (ITEM_SLOT_BELT|ITEM_SLOT_BACK)))
		return
	// Cancel the drag and do a delay, then complete it manually
	is_fumbling = TRUE
	INVOKE_ASYNC(src, PROC_REF(delayed_drag_unequip), wearer, dragged)
	return COMPONENT_CANCEL_MOUSEDROPPED_ONTO

/datum/component/ball_mittens_fumble/proc/delayed_drag_unequip(mob/living/wearer, obj/item/item)
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_purple("You fumble at your [item.name] with your [hand_desc]..."))
	if(!do_after(wearer, rand(struggle_delay_min, struggle_delay_max), item, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(wearer, span_warning("You give up on [item.name]."))
		is_fumbling = FALSE
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(item))
		is_fumbling = FALSE
		return
	if(!wearer.get_slot_by_item(item))
		is_fumbling = FALSE	// Already unequipped somehow
		return
	wearer.put_in_hands(item)
	is_fumbling = FALSE

/datum/component/ball_mittens_fumble/proc/on_try_strip(mob/living/wearer, atom/target, obj/item/item)
	SIGNAL_HANDLER
	// COMSIG_TRY_STRIP and COMSIG_BEING_STRIPPED share the same signal string.
	// get_slot_by_item returns non-null if the item is equipped on the wearer themselves.
	// If the item IS on the wearer, this signal is someone stripping THEM - allow it.
	// If the item is NOT on the wearer, the wearer is trying to strip someone else - block it.
	if(wearer.get_slot_by_item(item))
		return // Item is on wearer - someone else is stripping them, allow it
	to_chat(wearer, span_purple("You paw at their equipment, but can't seem to manage more than harmlessly bumping your [get_hand_descriptor(wearer)] into them."))
	return COMPONENT_CANT_STRIP

/// Multiplies breakout time for the current cuff escape attempt.
/// Uses a one-tick timer restore to avoid permanently mutating the cuffs var.
/// tracked_cuffs guard prevents double-mutation if the signal fires twice in rapid succession.
/datum/component/ball_mittens_fumble/proc/on_removing_cuffs(mob/living/wearer, obj/item/cuffs)
	SIGNAL_HANDLER
	if(!cuffs)
		return
	if(cuffs == tracked_cuffs) // already mid-mutation for this cuff item
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

/// Adds spread via the bonus_spread_values list in COMSIG_MOB_FIRED_GUN.
/// process_fire() reads this list BEFORE calculating randomized_gun_spread,
/// making this the correct hook for per-shot spread that works on full-auto.
/datum/component/ball_mittens_fumble/proc/on_fired_gun(mob/living/wearer, obj/item/gun/gun, atom/target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER
	if(!isgun(gun) || !islist(bonus_spread_values))
		return
	bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += gun_spread_penalty

/datum/component/ball_mittens_fumble/proc/fumble_interact(mob/living/wearer, atom/target, list/modifiers)
	// is_interacting was set true in on_clickon before scheduling this
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
		to_chat(wearer, span_warning("You give up on [target.name]."))
		is_interacting = FALSE
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(target) || get_dist(wearer, target) > max_fumble_range)
		is_interacting = FALSE
		return
	wearer.ClickOn(target, modifiers)
	is_interacting = FALSE

// ============================================================

/datum/atom_skin/ball_mittens_skin
	abstract_type = /datum/atom_skin/ball_mittens_skin

/datum/atom_skin/ball_mittens_skin/default
	preview_name = "Ball Mittens"
	reset_missing = TRUE

/datum/atom_skin/ball_mittens_skin/cat_paws
	preview_name = "Cat Paws"
	new_name = "latex paw mittens"
	new_desc = "A pair of inflatable latex mittens shaped like rounded paws. Helpless AND humiliating."
	change_worn_icon_state = FALSE
	// new_icon/new_icon_state are read directly by the radial menu - get_preview_icon is NOT called
	new_icon = 'modular_skyrat/modules/GAGS/icons/magpaws.dmi'
	new_icon_state = "Magpaw"
	// greyscale_item_path gives the loadout menu a proper GAGS preview for this skin
	greyscale_item_path = /obj/item/clothing/gloves/cat
	// new_worn_icon points to GAGS icons folder only, safe to list here
	new_worn_icon = 'modular_skyrat/modules/GAGS/icons/magpaws.dmi'

/datum/atom_skin/ball_mittens_skin/cat_paws/get_preview_icon(atom/for_atom)
	// Use the pre-colored Magpaw reference sprite for the radial menu preview.
	// This shows all three color layers. Full GAGS rendering happens in-game.
	return image(icon = 'modular_skyrat/modules/GAGS/icons/magpaws.dmi', icon_state = "Magpaw")

/datum/atom_skin/ball_mittens_skin/cat_paws/apply(atom/apply_to, mob/user)
	var/obj/item/clothing/gloves/ball_mittens/G = apply_to
	if(istype(G))
		// Set GAGS config before parent apply() so it skips the icon reset
		G.greyscale_config = /datum/greyscale_config/magpaws
		G.greyscale_config_worn = /datum/greyscale_config/magpaws/worn
		if(!G.greyscale_colors || G.greyscale_colors == "")
			G.greyscale_colors = "#d4d4d2#e590b9#15b1bf"
		G.flags_1 |= IS_PLAYER_COLORABLE_1
	. = ..()
	if(istype(G))
		G.is_paw_skin = TRUE
		G.worn_icon = 'modular_skyrat/modules/GAGS/icons/magpaws.dmi'
		G.icon_state = "magpaws"
		G.worn_icon_state = "magpaws_worn"
		G.set_greyscale(G.greyscale_colors, /datum/greyscale_config/magpaws)

/datum/atom_skin/ball_mittens_skin/cat_paws/clear_skin(atom/clear_from)
	var/obj/item/clothing/gloves/ball_mittens/G = clear_from
	if(istype(G))
		G.is_paw_skin = FALSE
		G.greyscale_config = null
		G.greyscale_config_worn = null
		G.flags_1 &= ~IS_PLAYER_COLORABLE_1
		G.icon_state = initial(G.icon_state)
		G.worn_icon_state = initial(G.worn_icon_state)
		G.worn_icon = initial(G.worn_icon)
	. = ..()
	if(istype(G))
		G.update_appearance()

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
	equip_sound = 'modular_zubbers/sound/lewd/rubber1.ogg'
	drop_sound = 'modular_zubbers/sound/lewd/rubber2.ogg'
	pickup_sound = 'modular_zubbers/sound/lewd/rubber3.ogg'
	armor_type = /datum/armor/ball_mittens
	var/is_paw_skin = FALSE
	var/spawn_flavor_shown = FALSE
	var/loadout_created = FALSE // Set TRUE in Initialize when created fresh by provide_type





/obj/item/clothing/gloves/ball_mittens/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_GLOVES)
		return
	if(is_paw_skin)
		to_chat(user, span_purple("The [src.name] seal around your hands. You pull at them and find it completely impossible to remove them..."))
	else
		to_chat(user, span_purple("Your hands sink into [src.name]. Soft, round, and not particularly good at anything. As soon as you put them on, you hear them self inflate. Oh shit..."))
	RegisterSignal(src, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(pre_unequip_block))
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))
	var/datum/component/ball_mittens_fumble/comp = AddComponent(/datum/component/ball_mittens_fumble)
	comp.register_wearer(user)

/obj/item/clothing/gloves/ball_mittens/dropped(mob/user)
	. = ..()
	UnregisterSignal(src, list(COMSIG_ITEM_PRE_UNEQUIP, COMSIG_OBJ_RESKIN))
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

/obj/item/clothing/gloves/ball_mittens/proc/pre_unequip_block(datum/source, force)
	SIGNAL_HANDLER
	if(force)
		return
	var/mob/living/wearer = loc
	if(!isliving(wearer))
		return
	// Route to doStrip async so the full 1-minute delay + timer message plays, same as the resist key path.
	// Show message and block. The player must use the resist key or click the mittens
	// directly to trigger the 1-minute do_after removal via doStrip.
	// Safeword bypasses this block via force=TRUE in inventory.dm.
	to_chat(wearer, span_purple("You struggle furiously with [src.name], but you\'re not even sure if these can come off."))
	return COMPONENT_ITEM_BLOCK_UNEQUIP

/// Opens the GAGS recolor menu for spray can use on paw mittens.
/// gags_recolorable.open_ui() uses initial() on greyscale_config which returns null
/// for runtime-assigned configs, so we open the menu with the live config directly.
/// Must return synchronously - INVOKE_ASYNC would return NONE and fail to block the signal chain.
/obj/item/clothing/gloves/ball_mittens/proc/paw_spray_interact(datum/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER
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
	var/list/allowed = list("[/datum/greyscale_config/magpaws]", "[/datum/greyscale_config/magpaws/worn]")
	var/datum/greyscale_modify_menu/spray_paint/menu = new(
		src, user.client, allowed,
		CALLBACK(src, PROC_REF(apply_spray_colors), can),
		"magpaws",
		/datum/greyscale_config/magpaws,
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
		playsound(loc, 'sound/effects/spray.ogg', 5, TRUE, 5)
	set_greyscale(menu.split_colors)

/// Intercepts spray can use on worn paw mittens.
/// Using item_interaction (called on the target before interact_with_atom) is more reliable
/// than COMSIG_ATOM_ITEM_INTERACTION which can be missed through HUD slot click paths.
/obj/item/clothing/gloves/ball_mittens/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_paw_skin && istype(tool, /obj/item/toy/crayon/spraycan))
		return paw_spray_interact(src, user, tool, modifiers)
	return ..()

/// Clicking yellow insulated gloves on ball mittens insulates them in place.
/// The insulated gloves are consumed. Preserves paw skin and colors.
/obj/item/clothing/gloves/ball_mittens/proc/deferred_spawn_flavor(mob/user)
	// Poll until the client is attached, then show the message.
	// Matches the pattern used by quirks for round-start messages.
	var/attempts = 0
	while(!user.client && attempts < 20)
		sleep(10)
		attempts++
	if(user.client)
		show_spawn_flavor(user)

/datum/armor/ball_mittens
	bio = 1

/// Overrides coverage check so surgery on arms/hands isn't blocked by the mittens.
/// Armor and slot-based systems are unaffected since those check slot, not coverage.
/mob/living/carbon/is_location_accessible(location, exluded_equipment_slots = NONE)
	if(istype(gloves, /obj/item/clothing/gloves/ball_mittens))
		exluded_equipment_slots |= ITEM_SLOT_GLOVES
	return ..()

/obj/item/clothing/gloves/ball_mittens/proc/show_spawn_flavor(mob/user)
	if(!user?.client)
		return
	if(is_paw_skin)
		to_chat(user, span_purple("You look down at your paws. Round and soft and utterly useless. You blush as you think about how difficult this is going to make your day at work."))
	else
		to_chat(user, span_purple("You look down at [src.name]. Why did I come to work like this?"))

/obj/item/clothing/gloves/ball_mittens/attackby(obj/item/item, mob/living/user, params)
	if(!istype(item, /obj/item/clothing/gloves/color/yellow))
		return ..()
	if(siemens_coefficient == 0)
		to_chat(user, span_warning("[src] are already insulated."))
		return
	// Print message BEFORE updating name so [src] still reads the pre-insulation name
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
		var/delay = 600 // 1 minute
		to_chat(owner, span_purple("You attempt to remove [src.name]... (This will take around [DisplayTimeText(delay)] and you need to stand still.)"))
		to_chat(owner, span_purple("You struggle furiously with [src.name], but you're not even sure if these can come off."))
		playsound(owner, pick('modular_zubbers/sound/lewd/rubber1.ogg', 'modular_zubbers/sound/lewd/rubber2.ogg', 'modular_zubbers/sound/lewd/rubber3.ogg'), 40, TRUE)
		if(!do_after(owner, delay, src, timed_action_flags = IGNORE_HELD_ITEM))
			to_chat(owner, span_purple("You give up trying to escape [src.name]. Maybe having [src.name] isn't so bad..."))
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
// greyscale_config at type level makes is_greyscale_item() return TRUE so the
// loadout color picker works. icon_preview points to the raw paw sprite for the
// catalog (the loadout UI reads type-level vars via :: so instance rendering doesn't help).
// ============================================================

/obj/item/clothing/gloves/ball_mittens/loadout_paw
	name = "latex paw mittens"
	desc = "A pair of inflatable latex mittens shaped like rounded paws. Helpless AND humiliating."
	greyscale_config = /datum/greyscale_config/magpaws
	greyscale_config_worn = /datum/greyscale_config/magpaws/worn
	greyscale_colors = "#d4d4d2#e590b9#15b1bf"
	flags_1 = IS_PLAYER_COLORABLE_1
	worn_icon = 'modular_skyrat/modules/GAGS/icons/magpaws.dmi'
	worn_icon_state = "magpaws_worn"
	icon_state = "BasePaws"
	post_init_icon_state = "magpaws" // Used by greyscale_previews to render map preview icons
	// Catalog uses icon_preview/icon_state_preview read at type level via ::
	icon_preview = 'modular_skyrat/modules/GAGS/icons/magpaws.dmi'
	icon_state_preview = "Magpaw" // Pre-colored reference sprite shows all three layers
	is_paw_skin = TRUE

/obj/item/clothing/gloves/ball_mittens/loadout_paw/Initialize(mapload)
	. = ..()
	loadout_created = TRUE // This type is only ever created by the loadout system
	// Remove all reskin components - loadout paw mittens are permanently in paw mode.
	// Uses GetComponents() rather than GetComponent() to safely handle COMPONENT_DUPE_SELECTIVE.
	for(var/datum/component/reskinable_item/c in GetComponents(/datum/component/reskinable_item))
		qdel(c)
	if(SSgreyscale?.initialized)
		update_greyscale()

/obj/item/clothing/gloves/ball_mittens/loadout_paw/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_GLOVES)
		return
	// Icon states must be set before set_greyscale so the pipeline reads them correctly.
	icon_state = "magpaws"
	worn_icon_state = "magpaws_worn"
	set_greyscale(greyscale_colors, /datum/greyscale_config/magpaws)

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

