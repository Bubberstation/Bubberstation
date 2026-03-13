/datum/component/item_dispenser
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/list/item_types = list() // List of item types to dispense
	var/atom/atom_parent

/datum/component/item_dispenser/Initialize(...)
	. = ..()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	setup_pool(get_turf(parent))
	atom_parent = parent
	atom_parent.add_filter("custom_interact_outline", 2, list("type" = "outline", "color" = "#fdad35", "size" = 1))

/datum/component/item_dispenser/Destroy(force)
	. = ..()
	atom_parent.remove_filter("custom_interact_outline")

/datum/component/item_dispenser/proc/setup_pool(turf/T)
	if(!T)
		return
	for(var/obj/item/I in T.contents)
		if(!istype(I) || I == parent)
			continue
		item_types += I.type
		qdel(I) // Remove the original to add to pool

/datum/component/item_dispenser/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(handle_interaction))

/datum/component/item_dispenser/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_ATOM_ATTACK_HAND)

/datum/component/item_dispenser/proc/handle_interaction(atom/self, mob/living/user, list/modifiers)
	// Build radial menu with items and "Claim All" option
	var/list/radial_options = list()
	for(var/item_type in item_types)
		var/obj/item/I = item_type
		radial_options[initial(I.name)] = image(icon = initial(I.icon), icon_state = initial(I.icon_state))
	radial_options["Claim All"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_pickup") // Use a suitable icon

	var/choice = show_radial_menu(user, parent, radial_options, radius = 38, require_near = TRUE)
	if(!choice || get_dist(parent, user) > 1)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(choice == "Claim All")
		// Spawn all items
		for(var/item_type in item_types)
			var/obj/item/new_item = new item_type(user.loc)
			user.put_in_hands(new_item)
		atom_parent.balloon_alert(user, "claimed all items")
	else
		// Spawn selected item
		for(var/item_type in item_types)
			var/obj/item/I = item_type
			if(initial(I.name) == choice)
				var/obj/item/new_item = new item_type(user.loc)
				user.put_in_hands(new_item)
				atom_parent.balloon_alert(user, "claimed [initial(I.name)]")
				break
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/item_dispenser/unlimited
	// Unlimited dispenser: anyone can claim items any number of times

/datum/component/item_dispenser/limited
	var/max_items = 10 // Maximum number of total items to dispense
	var/items_dispensed = 0 // Current number of items dispensed

/datum/component/item_dispenser/limited/handle_interaction(atom/self, mob/living/user, list/modifiers)
	if(items_dispensed >= max_items)
		atom_parent.balloon_alert(user, "dispenser empty!")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	// Build radial menu with items and "Claim All" option
	var/list/radial_options = list()
	for(var/item_type in item_types)
		var/obj/item/I = item_type
		radial_options[initial(I.name)] = image(icon = initial(I.icon), icon_state = initial(I.icon_state))
	radial_options["Claim All"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_claim")

	var/choice = show_radial_menu(user, parent, radial_options, radius = 38, require_near = TRUE)
	if(!choice || get_dist(parent, user) > 1)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(choice == "Claim All")
		var/items_claimed = 0
		for(var/item_type in item_types)
			if(items_dispensed >= max_items)
				break
			var/obj/item/new_item = new item_type(user.loc)
			user.put_in_hands(new_item)
			items_dispensed++
			items_claimed++
		atom_parent.balloon_alert(user, "claimed [items_claimed] items")
	else
		// Spawn selected item
		for(var/item_type in item_types)
			var/obj/item/I = item_type
			if(initial(I.name) == choice)
				var/obj/item/new_item = new item_type(user.loc)
				user.put_in_hands(new_item)
				items_dispensed++
				atom_parent.balloon_alert(user, "claimed [initial(I.name)]")
				break

	if(items_dispensed >= max_items)
		atom_parent.balloon_alert(user, "dispenser now empty")

	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/item_dispenser/player_bound
	var/list/claimed_items_by_ckey = list() // Assoc list: ckey = list of claimed item types

/datum/component/item_dispenser/player_bound/handle_interaction(atom/self, mob/living/user, list/modifiers)
	var/ckey = user.ckey
	if(!ckey)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	var/list/claimed = claimed_items_by_ckey[ckey]
	if(!claimed)
		claimed = list()
		claimed_items_by_ckey[ckey] = claimed

	if(claimed.len >= item_types.len)
		atom_parent.balloon_alert(user, "already claimed all items!")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	// Build radial menu with remaining items and "Claim All" option
	var/list/radial_options = list()
	for(var/item_type in item_types)
		if(item_type in claimed)
			continue
		var/obj/item/I = item_type
		radial_options[initial(I.name)] = image(icon = initial(I.icon), icon_state = initial(I.icon_state))
	if(radial_options.len > 0)
		radial_options["Claim All"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_claim")

	var/choice = show_radial_menu(user, parent, radial_options, radius = 38, require_near = TRUE)
	if(!choice || get_dist(parent, user) > 1)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(choice == "Claim All")
		// Spawn all remaining items
		for(var/item_type in item_types)
			if(item_type in claimed)
				continue
			var/obj/item/new_item = new item_type(user.loc)
			user.put_in_hands(new_item)
			claimed += item_type
		atom_parent.balloon_alert(user, "claimed all remaining items")
	else
		// Spawn selected item
		for(var/item_type in item_types)
			var/obj/item/I = item_type
			if(initial(I.name) == choice && !(item_type in claimed))
				var/obj/item/new_item = new item_type(user.loc)
				user.put_in_hands(new_item)
				claimed += item_type
				atom_parent.balloon_alert(user, "claimed [initial(I.name)]")
				break

	if(claimed.len >= item_types.len)
		atom_parent.balloon_alert(user, "claimed all available items")

	return COMPONENT_CANCEL_ATTACK_CHAIN



/obj/effect/mapping_helpers/item_dispenser
	name = "Item dispenser"
	icon_state = "sort_type_helper_sup"
	var/target_dispenser_type = null
	var/dispenser_component = /datum/component/item_dispenser
	var/list/allowed_item_types

/obj/effect/mapping_helpers/item_dispenser/Initialize(mapload)
	. = ..()
	if(mapload && target_dispenser_type)
		if(!ispath(target_dispenser_type, /atom))
			log_mapping("[src] at [loc] has invalid target_dispenser_type: [target_dispenser_type]. Must be a valid atom path.")
			qdel(src)
			return
		if(!ispath(dispenser_component, /datum/component/item_dispenser))
			log_mapping("[src] at [loc] has invalid dispenser_component: [dispenser_component]. Must be a valid item_dispenser subtype.")
			qdel(src)
			return
		var/atom/target = locate(target_dispenser_type) in loc
		if(!target)
			target = new target_dispenser_type(loc)
		target.AddComponent(dispenser_component, allowed_item_types)
	qdel(src)

/obj/effect/mapping_helpers/item_dispenser/unlimited
	name = "Ulimited item dispenser"
	desc = "Adds an unlimited item dispenser component to a specified atom."
	dispenser_component = /datum/component/item_dispenser/unlimited

/obj/effect/mapping_helpers/item_dispenser/limited
	name = "Limited item dispenser"
	desc = "Adds a limited item dispenser component to a specified atom."
	dispenser_component = /datum/component/item_dispenser/limited
	var/max_claims = 10

/obj/effect/mapping_helpers/item_dispenser/limited/Initialize(mapload)
	. = ..()
	if(mapload)
		var/atom/target = locate(target_dispenser_type) in loc
		if(target)
			var/datum/component/item_dispenser/limited/C = target.GetComponent(/datum/component/item_dispenser/limited)
			if(C)
				C.max_items = max_claims

/obj/effect/mapping_helpers/item_dispenser/limited/five
	max_claims = 5

/obj/effect/mapping_helpers/item_dispenser/limited/twenty
	max_claims = 20

/obj/effect/mapping_helpers/item_dispenser/player_bound
	name = "Item dispenser(player garanted)"
	desc = "Adds a player-bound item dispenser component to a specified atom."
	dispenser_component = /datum/component/item_dispenser/player_bound

