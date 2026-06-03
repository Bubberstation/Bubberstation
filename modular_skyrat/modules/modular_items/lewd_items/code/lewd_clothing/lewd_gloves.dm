
/datum/component/ball_mittens_fumble
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/struggle_delay_min = 0.8 SECONDS
	var/interact_delay = 1.5 SECONDS
	var/max_item_size = WEIGHT_CLASS_HUGE
	var/cuff_resist_multiplier = 3
	var/gun_spread_penalty = 12
	var/is_interacting = FALSE
	var/obj/item/tracked_cuffs = null

/datum/component/ball_mittens_fumble/Initialize()
	. = ..()
	if(!istype(parent, /obj/item/clothing/gloves/ball_mittens))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(on_pre_unequip))

/datum/component/ball_mittens_fumble/proc/register_wearer(mob/living/wearer)
	var/obj/item/clothing/gloves/ball_mittens/mittens = parent
	if(mittens.is_paw_skin && isliving(wearer))
		wearer.add_mood_event("paw_mittens", /datum/mood_event/wearing_paw_mittens)
	if(!mittens.spawn_flavor_shown && mittens.loadout_created)
		mittens.spawn_flavor_shown = TRUE
		INVOKE_ASYNC(mittens, TYPE_PROC_REF(/obj/item/clothing/gloves/ball_mittens, deferred_spawn_flavor), wearer)
	ADD_TRAIT(wearer, TRAIT_GLOVE_SURGERY_PASSTHROUGH, MITTENS_FUMBLE_TRAIT)
	RegisterSignal(wearer, COMSIG_LIVING_ITEM_ATTEMPT_PICKUP, PROC_REF(on_attempt_pickup))
	RegisterSignal(wearer, COMSIG_LIVING_ITEM_PICKUP_FAILED, PROC_REF(on_pickup_failed))
	RegisterSignal(wearer, COMSIG_LIVING_TRY_PUT_IN_HAND, PROC_REF(on_try_pickup))
	RegisterSignal(wearer, COMSIG_MOB_MACHINERY_INTERACT, PROC_REF(on_machinery_interact))
	RegisterSignal(wearer, COMSIG_MOB_CLICKON, PROC_REF(on_clickon))
	RegisterSignal(wearer, COMSIG_MOB_REMOVING_CUFFS, PROC_REF(on_removing_cuffs))
	RegisterSignal(wearer, COMSIG_MOB_FIRED_GUN, PROC_REF(on_fired_gun))
	RegisterSignal(wearer, COMSIG_TRY_STRIP, PROC_REF(on_try_strip))
	RegisterSignal(wearer, COMSIG_BEING_STRIPPED, PROC_REF(on_being_stripped))
	RegisterSignal(wearer, COMSIG_MOUSEDROPPED_ONTO, PROC_REF(on_mousedrop_receive))
	RegisterSignal(wearer, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))

/datum/component/ball_mittens_fumble/proc/unregister_wearer(mob/living/wearer)
	if(!isliving(wearer))
		return
	wearer.clear_mood_event("paw_mittens")
	REMOVE_TRAIT(wearer, TRAIT_GLOVE_SURGERY_PASSTHROUGH, MITTENS_FUMBLE_TRAIT)
	UnregisterSignal(wearer, list(
		COMSIG_LIVING_ITEM_ATTEMPT_PICKUP,
		COMSIG_LIVING_ITEM_PICKUP_FAILED,
		COMSIG_LIVING_TRY_PUT_IN_HAND,
		COMSIG_MOB_MACHINERY_INTERACT,
		COMSIG_MOB_CLICKON,
		COMSIG_MOB_REMOVING_CUFFS,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_TRY_STRIP,
		COMSIG_BEING_STRIPPED,
		COMSIG_LIVING_UNARMED_ATTACK,
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

/datum/component/ball_mittens_fumble/proc/get_hand_descriptor(mob/living/wearer)
	if(!iscarbon(wearer))
		return "chunky mitts"
	var/mob/living/carbon/human/human_wearer = wearer
	var/obj/item/clothing/gloves/ball_mittens/mittens = human_wearer.gloves
	if(istype(mittens) && mittens.is_paw_skin)
		return "paws"
	return "chunky mitts"

/// Intercepts item pickups via attempt_pickup. Enforces the one-item limit and injects a short pickup delay.
/datum/component/ball_mittens_fumble/proc/on_attempt_pickup(mob/living/wearer, obj/item/item, list/pickup_mods)
	SIGNAL_HANDLER
	if(item.item_flags & ABSTRACT)
		return
	if(!isgun(item) && item.w_class >= max_item_size)
		pickup_mods["delay"] = struggle_delay_min * (item.w_class - max_item_size + 2)
		pickup_mods["fail_chance"] = min(75, (item.w_class - max_item_size) * 25)
		to_chat(wearer, span_warning("You wrestle with [item], trying to get it between your [get_hand_descriptor(wearer)]..."))
		return
	var/hand_desc = get_hand_descriptor(wearer)
	var/player_msgs = list(
		"You awkwardly wedge the [item] between your [hand_desc]...",
		"You clumsily pin the [item] between your [hand_desc]...",
		"You struggle to secure the [item] in your [hand_desc] before finally succeeding.",
		"You carefully balance the [item] between your unwieldy [hand_desc]..."
	)
	to_chat(wearer, span_purple(pick(player_msgs)))
	var/public_msg
	if(isgun(item))
		var/gun_msgs = list(
			"[wearer] takes hold of the [item] in defiance of common sense.",
			"[wearer] awkwardly presses the [item] between [wearer.p_their()] [hand_desc].",
			"[wearer] picks up the [item], awkwardly pressing [wearer.p_their()] pads against the trigger guard!"
		)
		public_msg = pick(gun_msgs)
	else
		var/general_msgs = list(
			"[wearer] awkwardly secures the [item] in [wearer.p_their()] [hand_desc].",
			"[wearer] carefully grips the [item] with [wearer.p_their()] [hand_desc].",
			"[wearer] almost drops [item] before managing to press it between [wearer.p_their()] [hand_desc].",
			"[wearer] carefully balances the [item] between [wearer.p_their()] [hand_desc]."
		)
		public_msg = pick(general_msgs)
	wearer.visible_message(span_warning(public_msg))
	pickup_mods["delay"] = struggle_delay_min

/datum/component/ball_mittens_fumble/proc/on_pickup_failed(mob/living/wearer, obj/item/item)
	SIGNAL_HANDLER
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_warning("[item] slips out of your [hand_desc]!"))
	playsound(wearer, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 30, TRUE)

/// Safety net for drag-drop paths that bypass attempt_pickup.
/datum/component/ball_mittens_fumble/proc/on_try_pickup(mob/living/wearer, obj/item/to_pick_up)
	SIGNAL_HANDLER
	if(to_pick_up.item_flags & ABSTRACT)
		return
	if(ismob(to_pick_up.loc))
		return

/// Handles machinery interaction delay via COMSIG_MOB_MACHINERY_INTERACT.
/datum/component/ball_mittens_fumble/proc/on_machinery_interact(mob/living/wearer, obj/machinery/machine)
	SIGNAL_HANDLER
	if(is_interacting)
		return
	// Simple toggle/single-action machines trivial to operate with a paw - bypass delay
	var/static/list/paw_passthrough = typecacheof(list(
		/obj/machinery/button,
		/obj/machinery/photobooth,
		/obj/machinery/light_switch,
		/obj/machinery/shower,
	))
	if(is_type_in_typecache(machine, paw_passthrough))
		return
	INVOKE_ASYNC(src, PROC_REF(fumble_interact), wearer, machine)
	return COMPONENT_BLOCK_MACHINERY_INTERACT

/datum/component/ball_mittens_fumble/proc/on_clickon(mob/living/wearer, atom/target, list/modifiers)
	SIGNAL_HANDLER
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
	if(modifiers && (LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, ALT_CLICK) || LAZYACCESS(modifiers, RIGHT_CLICK) || LAZYACCESS(modifiers, CTRL_CLICK)))
		return
	if(get_dist(wearer, target) > 1)
		return
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

/datum/component/ball_mittens_fumble/proc/clothing_struggle(mob/living/wearer, obj/item/clothing/cloth)
	var/delay = 12 SECONDS
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_purple("You struggle to remove [cloth]. It's extremely difficult with your [hand_desc]... (This will take around [DisplayTimeText(delay)] and you need to stand still.)"))
	if(!do_after(wearer, delay, cloth, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(wearer, span_warning("You give up on [cloth]."))
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(cloth))
		return
	wearer.dropItemToGround(cloth)

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
	INVOKE_ASYNC(src, PROC_REF(delayed_drag_unequip), wearer, dragged)
	return COMPONENT_CANCEL_MOUSEDROPPED_ONTO

/datum/component/ball_mittens_fumble/proc/delayed_drag_unequip(mob/living/wearer, obj/item/item)
	var/hand_desc = get_hand_descriptor(wearer)
	to_chat(wearer, span_purple("You carefully work at your [item] with your [hand_desc]..."))
	if(!do_after(wearer, struggle_delay_min, item, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(wearer, span_warning("You give up on [item]."))
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(item))
		return
	if(!wearer.get_slot_by_item(item))
		return
	wearer.put_in_hands(item)

/datum/component/ball_mittens_fumble/proc/on_try_strip(mob/living/wearer, atom/target, obj/item/item)
	SIGNAL_HANDLER
	// Wearer is trying to strip someone else - apply fumble delay
	if(!isliving(target) || !isitem(item))
		return COMPONENT_CANT_STRIP
	if(wearer.get_slot_by_item(item))
		return // Item is on the wearer themselves - allow normally
	to_chat(wearer, span_purple("You fumble awkwardly at [target]'s gear with your [get_hand_descriptor(wearer)], trying to find a grip..."))
	INVOKE_ASYNC(src, PROC_REF(delayed_strip), wearer, target, item)
	return COMPONENT_CANT_STRIP

/// Fires on the wearer when someone else acts on them via the strip menu.
/datum/component/ball_mittens_fumble/proc/on_being_stripped(mob/living/wearer, mob/living/user, obj/item/item)
	SIGNAL_HANDLER
	if(!isitem(item))
		return
	// Item not on wearer - this is an equip action, always allow
	if(!wearer.get_slot_by_item(item))
		return
	// Item is on wearer - this is a strip. Pass through to normal strip flow and doStrip.

/datum/component/ball_mittens_fumble/proc/delayed_strip(mob/living/wearer, mob/living/target, obj/item/item)
	if(!do_after(wearer, item.strip_delay * 2.5, target, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(wearer, span_warning("You give up trying to remove [item] from [target]."))
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(target) || QDELETED(item))
		return
	item.doStrip(wearer, target)

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

/datum/component/ball_mittens_fumble/proc/fumble_interact(mob/living/wearer, obj/machinery/machine)
	is_interacting = TRUE
	var/hand_desc = get_hand_descriptor(wearer)
	var/msg = istype(machine, /obj/machinery/vending) ? \
		"You awkwardly mash your [hand_desc] against [machine]'s keypad..." : \
		"You awkwardly paw at [machine] with your [hand_desc]..."
	wearer.face_atom(machine)
	to_chat(wearer, span_purple(msg))
	wearer.visible_message(span_warning("[wearer] awkwardly paws at [machine] with [wearer.p_their()] [hand_desc], visibly struggling to use it."))
	if(!do_after(wearer, interact_delay, machine))
		to_chat(wearer, span_warning("You give up on [machine]."))
		is_interacting = FALSE
		return
	if(QDELETED(src) || QDELETED(wearer) || QDELETED(machine) || get_dist(wearer, machine) > 1)
		is_interacting = FALSE
		return
	machine.interact(wearer)
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
	desc = "A pair of inflatable latex mittens. Adorable and comfortable, but completely useless for anything requiring fingers. Getting these off yourself is a serious ordeal — you'll probably want help."
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
	var/lights_on = FALSE

/obj/item/clothing/gloves/ball_mittens/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

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

/obj/item/clothing/gloves/ball_mittens/update_overlays()
	. = ..()
	if(lights_on && is_paw_skin)
		. += emissive_appearance(icon, icon_state, src, alpha = 100)

/obj/item/clothing/gloves/ball_mittens/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(lights_on && is_paw_skin)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = 100)

/obj/item/clothing/gloves/ball_mittens/examine(mob/user)
	. = ..()
	if(is_paw_skin)
		. += span_notice("There's a paw-friendly switch on the cuff. It's currently <b>[lights_on ? "ON" : "OFF"]</b>. <a href='byond://?src=[REF(src)];toggle_lights=1'>\[Toggle\]</a>")

/obj/item/clothing/gloves/ball_mittens/Topic(href, href_list)
	. = ..()
	if(href_list["toggle_lights"])
		if(!usr || !istype(usr, /mob/living))
			return
		var/mob/living/carbon/human/toggler = usr
		if(toggler.gloves != src)
			return
		lights_on = !lights_on
		playsound(src, 'sound/machines/click.ogg', 30, FALSE)
		to_chat(usr, span_notice("You turn the accent lighting [lights_on ? "on" : "off"]."))
		update_appearance()

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
	name = "insulated [name]"
	if(desc == initial(desc))
		desc = "A pair of inflatable latex mittens. Someone has helpfully applied insulated gloves to them, only to realise too late that latex was already an insulator."
	qdel(item)
	update_appearance()
	return TRUE

/obj/item/clothing/gloves/ball_mittens/doStrip(mob/stripper, mob/owner)
	if(stripper != owner)
		return ..()
	var/delay = 1 MINUTES
	to_chat(owner, span_purple("You attempt to remove [src]... (This will take around [DisplayTimeText(delay)] and you need to stand still.)"))
	to_chat(owner, span_purple("You struggle furiously with [src], but you're not even sure if these can come off."))
	playsound(owner, pick('modular_zubbers/sound/lewd/rubber1.ogg', 'modular_zubbers/sound/lewd/rubber2.ogg', 'modular_zubbers/sound/lewd/rubber3.ogg'), 40, TRUE)
	if(!do_after(owner, delay, src, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(owner, span_purple("You give up trying to escape [src]. Maybe having [src] isn't so bad..."))
		return FALSE
	if(QDELETED(src) || !isliving(loc))
		return FALSE
	return ..()

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
	icon_state = "catgloves"
	worn_icon_state = "catgloves"
	set_greyscale(greyscale_colors, /datum/greyscale_config/catgloves)
	. = ..()

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
