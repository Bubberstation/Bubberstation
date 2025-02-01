//// Boulder Stabilizing Collector - Allows for ghost roles to have boulder-based ore vents without NT Yoinking them.

/obj/structure/ore_box/boulder_collector //We want this to automatically grab boulders and desync them from the bluespace boulder grabbers
	name = "BSC Refinery Box"
	desc = "An improvement on the normal boxes drudged around by miners, The \"Boulder Stabilizing Collector\" is capable of automatically picking up and safely storing ores or boulders in a set direction once established."
	icon = 'modular_nova/modules/ghost_mining/icons/mining.dmi'
	icon_state = "orebox"
	resistance_flags = FIRE_PROOF|LAVA_PROOF
	/// The current direction of `input_turf`, in relation to the orebox.
	var/input_dir = NORTH
	/// The turf the orebox listens to for items to pick up. Calls the `pickup_item()` proc.
	var/turf/input_turf = null
	/// Determines if this orebox needs to pick up items yet
	var/needs_item_input = FALSE
	var/repacked_type = /obj/item/flatpacked_machine/boulder_collector
	var/perpetual = FALSE //If it breaks, will it drop its compressed form? Used for gulag

/obj/structure/ore_box/boulder_collector/atom_deconstruct(disassembled = TRUE)
	dump_box_contents()
	if(perpetual)
		new repacked_type(get_turf(src))

/obj/structure/ore_box/boulder_collector/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)

/obj/structure/ore_box/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_ALT_LMB] = "Rotate"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "[anchored ? "Loosen" : "Anchor"]"
	if(held_item.tool_behaviour == TOOL_CROWBAR)
		context[SCREENTIP_CONTEXT_LMB] = "Deconstruct"
		return CONTEXTUAL_SCREENTIP_SET
	else if(istype(held_item, /obj/item/stack/ore) || istype(held_item, /obj/item/boulder))
		context[SCREENTIP_CONTEXT_LMB] = "Insert Item"
		return CONTEXTUAL_SCREENTIP_SET
	else if(held_item.atom_storage)
		context[SCREENTIP_CONTEXT_LMB] = "Transfer Contents"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/ore_box/boulder_collector/proc/register_input_turf()
	input_turf = get_step(src, input_dir)
	if(input_turf) // make sure there is actually a turf
		RegisterSignals(input_turf, list(COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, COMSIG_ATOM_ENTERED), PROC_REF(pickup_item))

/obj/structure/ore_box/boulder_collector/proc/unregister_input_turf()
	if(input_turf)
		UnregisterSignal(input_turf, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON))

/obj/structure/ore_box/boulder_collector/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(!needs_item_input || !anchored)
		return
	unregister_input_turf()
	register_input_turf()

/obj/structure/ore_box/boulder_collector/click_alt(mob/living/user)
	input_dir = turn(input_dir, -90)
	to_chat(user, span_notice("You change [src]'s I/O settings, setting the input to [dir2text(input_dir)]."))
	unregister_input_turf() // someone just rotated the input directions, unregister the old turf
	register_input_turf() // register the new one
	update_appearance(UPDATE_OVERLAYS)
	return CLICK_ACTION_SUCCESS

/obj/structure/ore_box/boulder_collector/update_overlays()
	. = ..()
	if(anchored == FALSE)
		return
	var/image/ore_input = image(icon='icons/obj/doors/airlocks/station/overlays.dmi', icon_state="unres_[input_dir]")

	switch(input_dir)
		if(NORTH)
			ore_input.pixel_y = 32
		if(SOUTH)
			ore_input.pixel_y = -32
		if(EAST)
			ore_input.pixel_x = 32
		if(WEST)
			ore_input.pixel_x = -32

	ore_input.color = COLOR_MODERATE_BLUE
	var/mutable_appearance/light_in = emissive_appearance(ore_input.icon, ore_input.icon_state, offset_spokesman = src, alpha = ore_input.alpha)
	light_in.pixel_y = ore_input.pixel_y
	light_in.pixel_x = ore_input.pixel_x
	. += ore_input
	. += light_in

/obj/structure/ore_box/boulder_collector/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(default_unfasten_wrench(user, tool))
		update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/ore_box/boulder_collector/can_be_unfasten_wrench(mob/user, silent)
	if(!(isfloorturf(loc) || isindestructiblefloor(loc) || ismiscturf(loc)) && !anchored)
		to_chat(user, span_warning("[src] needs to be on the ground to be secured!"))
		return FAILED_UNFASTEN
	return SUCCESSFUL_UNFASTEN

/obj/structure/ore_box/boulder_collector/default_unfasten_wrench(mob/user, obj/item/wrench, time)
	. = ..()
	if(. != SUCCESSFUL_UNFASTEN)
		return
	if(anchored)
		register_input_turf() // someone just wrenched us down, re-register the turf
		needs_item_input = TRUE
	else
		unregister_input_turf() // someone just un-wrenched us, unregister the turf
		needs_item_input = FALSE

/obj/structure/ore_box/boulder_collector/proc/pickup_item(datum/source, atom/movable/target_boulder, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(QDELETED(target_boulder))
		return

	if(istype(target_boulder, /obj/item/boulder))
		var/obj/item/boulder/mine_now = target_boulder
		mine_now.forceMove(src) //Pull the boulder into storage
		SSore_generation.available_boulders -= mine_now //Decouple the boulder from the network. Cant be stolen
	return

/obj/structure/ore_box/boulder_collector/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/boulder))
		var/obj/item/boulder/mine_now = weapon
		SSore_generation.available_boulders -= mine_now
		user.transferItemToLoc(weapon, src)
	else
		return ..()

/obj/structure/ore_box/boulder_collector/syndicate
	name = "Suspicious BSC Box"
	desc = "An improvement on the normal boxes drudged around by miners, \
	It is capable of being set up to automatically pick up ores or boulders \
	in a set direction. It is plated in suspiciously coloured panels."
	icon_state = "orebox_s"
	repacked_type = /obj/item/flatpacked_machine/boulder_collector/syndicate
	perpetual = TRUE

/obj/structure/ore_box/boulder_collector/tarkon
	name = "Tarkon BSC Box"
	desc = "An improvement on the normal boxes drudged around by miners, \
	It is capable of being set up to automatically pick up ores or boulders \
	in a set direction. It is plated in Tarkon-coloured panels."
	icon_state = "orebox_t"
	repacked_type = /obj/item/flatpacked_machine/boulder_collector/tarkon

/obj/structure/ore_box/boulder_collector/nt
	name = "NT BSC Refinery Box"
	desc = "An improvement on the normal boxes drudged around by miners, \
	It is capable of being set up to automatically pick up ores or boulders \
	in a set direction. It is plated in NT-coloured panels."
	icon_state = "orebox_n"
	repacked_type = /obj/item/flatpacked_machine/boulder_collector/nt

/obj/structure/ore_box/boulder_collector/gulag
	name = "Boulder Snatchinator 3000"
	desc = "A mess of pipes, orange heatform plastic and cardboard paneling. \
	The fact this is not immediately falling apart is a miracle, let alone the fact \
	that it can not only hold, but be set up to automatically collect boulders from vents \
	is an impressive showmanship of cost-cutting engineering."
	icon_state = "orebox_g"
	max_integrity = 100 //Default is 300
	repacked_type = /obj/item/flatpacked_machine/boulder_collector/gulag
	perpetual = TRUE

/obj/item/flatpacked_machine/boulder_collector
	name = "compacted BSC Box"
	/// For all flatpacked machines, set the desc to the type_to_deploy followed by ::desc to reuse the type_to_deploy's description
	desc = /obj/structure/ore_box/boulder_collector::desc
	icon = 'modular_nova/modules/ghost_mining/icons/mining.dmi'
	icon_state = "orecube"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF|LAVA_PROOF
	type_to_deploy = /obj/structure/ore_box/boulder_collector

/obj/item/flatpacked_machine/boulder_collector/syndicate
	name = "compacted Suspicious BSC Box"
	desc = /obj/structure/ore_box/boulder_collector/syndicate::desc
	icon_state = "orecube_s"
	w_class = WEIGHT_CLASS_BULKY
	type_to_deploy = /obj/structure/ore_box/boulder_collector/syndicate

/obj/item/flatpacked_machine/boulder_collector/syndicate/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_REMOVED) //pretty sus there

/obj/item/flatpacked_machine/boulder_collector/tarkon
	name = "compacted Tarkon BSC Box"
	desc = /obj/structure/ore_box/boulder_collector/tarkon::desc
	icon_state = "orecube_t"
	w_class = WEIGHT_CLASS_BULKY
	type_to_deploy = /obj/structure/ore_box/boulder_collector/tarkon

/obj/item/flatpacked_machine/boulder_collector/tarkon/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_REMOVED) //tarkon doesn't have manfact examine yet. they would, however, actually make it.

/obj/item/flatpacked_machine/boulder_collector/nt
	name = "compacted NT BSC Box"
	desc = /obj/structure/ore_box/boulder_collector/nt::desc
	icon_state = "orecube_n"
	w_class = WEIGHT_CLASS_BULKY
	type_to_deploy = /obj/structure/ore_box/boulder_collector/nt

/obj/item/flatpacked_machine/boulder_collector/nt/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_REMOVED) //Why would Nanotrasen ARMORY build a fucking box lmao? Besides, its just atker but stolen and painted.

/obj/item/flatpacked_machine/boulder_collector/gulag
	name = "\improper Boulder Snatchinator 3000 Build-it kit"
	desc = /obj/structure/ore_box/boulder_collector/gulag::desc
	icon_state = "orecube_g"
	w_class = WEIGHT_CLASS_BULKY
	type_to_deploy = /obj/structure/ore_box/boulder_collector/gulag

/obj/item/flatpacked_machine/boulder_collector/gulag/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_REMOVED) //You try keeping manufacturing stamps on fucking cardboard
