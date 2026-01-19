/obj/structure/rack
	icon = 'modular_skyrat/modules/aesthetics/rack/icons/rack.dmi'

/obj/structure/rack/shelf
	name = "shelf"
	desc = "A shelf, for storing things on. Conveinent!"
	icon = 'modular_skyrat/modules/aesthetics/rack/icons/rack.dmi'
	icon_state = "shelf"

/obj/structure/rack/Initialize(mapload)
	. = ..()

/obj/structure/rack/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(isnull(held_item))
		return .

	// Add tooltips if the item is not a wrench (wrenches handled by parent)
	if(held_item.tool_behaviour != TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "Precise placement"
		context[SCREENTIP_CONTEXT_RMB] = "Center item"
		. |= CONTEXTUAL_SCREENTIP_SET

	return .

/obj/structure/rack/base_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	// Wrench deconstruction
	if(tool.tool_behaviour == TOOL_WRENCH)
		return ..()

	// Right click to center item placement
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(user.transfer_item_to_turf(tool, get_turf(src), silent = FALSE))
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING

	// Left click for precise placement
	if(LAZYACCESS(modifiers, ICON_X) && LAZYACCESS(modifiers, ICON_Y))
		var/x_offset = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(ICON_SIZE_X * 0.5), ICON_SIZE_X * 0.5)
		var/y_offset = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(ICON_SIZE_Y * 0.5), ICON_SIZE_Y * 0.5)
		if(user.transfer_item_to_turf(tool, get_turf(src), x_offset, y_offset, silent = FALSE))
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING

	// Default rack behavior otherwise
	return ..()

/obj/item/gun
	var/on_rack = FALSE

/obj/item/gun/proc/place_on_rack()
	on_rack = TRUE
	var/matrix/M = matrix()
	M.Turn(-90)
	transform = M

/obj/item/gun/proc/remove_from_rack()
	if(on_rack)
		var/matrix/M = matrix()
		transform = M
		on_rack = FALSE

/obj/item/gun/pickup(mob/user)
	. = ..()
	remove_from_rack()

/obj/structure/rack/gunrack
	name = "gun rack"
	desc = "A gun rack for storing guns."
	icon_state = "gunrack"

/obj/structure/rack/gunrack/Initialize(mapload)
	. = ..()
	if(mapload)
		for(var/obj/item/I in loc.contents)
			if(istype(I, /obj/item/gun))
				var/obj/item/gun/to_place = I
				to_place.place_on_rack()

/obj/structure/rack/gunrack/attackby(obj/item/W, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if (W.tool_behaviour == TOOL_WRENCH && LAZYACCESS(modifiers, RIGHT_CLICK))
		W.play_tool_sound(src)
		deconstruct(TRUE)
		return
	if(user.combat_mode)
		return ..()
	if(user.transferItemToLoc(W, drop_location()))
		if(istype(W, /obj/item/gun))
			var/obj/item/gun/our_gun = W
			our_gun.place_on_rack()
			our_gun.pixel_x = rand(-10, 10)
		return TRUE
