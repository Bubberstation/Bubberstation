/// Typecache of all objects that we seek out to apply a neighbor stripe overlay
GLOBAL_VAR_INIT(neighbor_typecache, typecacheof(list(
	/obj/machinery/door/airlock,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/shuttle,
	/obj/machinery/door/poddoor,
	/obj/structure/window/reinforced/plasma/fulltile,
	/obj/structure/window/plasma/fulltile,
)))
GLOBAL_LIST_EMPTY(wall_overlays_cache)

/turf/closed
	//These are set by the material, do not touch!!!
	var/material_color
	var/shiny_wall

	var/icon/shiny_wall_icon

	var/stripe_icon
	var/icon/shiny_stripe_icon
	/// Material Set Name
	var/matset_name
	//Ok you can touch vars again :)

	/// Paint color of which the wall has been painted with.
	var/wall_paint
	/// Paint color of which the stripe has been painted with. Will not overlay a stripe if no paint is applied
	var/stripe_paint

	/// If TRUE, this wall will not try to use any of the fancy toblerone wall systems. Used for some things that don't have proper mats (meat/pizza walls, for example)
	var/custom_wall

	/// This is a lazy workaround to not override every single wall subtype's smoothing settings. Set this to override smoothing settings for custom walls.
	var/custom_smoothing_groups

	/// Appearance cache key. This is very touchy.
	VAR_PRIVATE/cache_key

	var/static/list/custom_walls = list()

	/// A lookup list cause calculating the material from scratch can take a few steps, and micro-ops to this does have a slight benefit to init times.
	var/static/list/material_cache = list()

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/update_overlays()
	if(custom_wall)
		return ..()

	var/plating_color = wall_paint || material_color
	var/stripe_color = stripe_paint || wall_paint || material_color

	var/neighbor_stripe = NONE
	var/area/source_area = get_area(src)
	for (var/cardinal in GLOB.cardinals)
		var/turf/step_turf = get_step(src, cardinal)
		var/area/target_area = get_area(step_turf)
		if(!target_area || ((source_area.area_limited_icon_smoothing && !istype(target_area, source_area.area_limited_icon_smoothing)) || (target_area.area_limited_icon_smoothing && !istype(source_area, target_area.area_limited_icon_smoothing))))
			continue
		for(var/atom/movable/movable_thing as anything in step_turf)
			if(GLOB.neighbor_typecache[movable_thing.type])
				neighbor_stripe ^= cardinal
				break

	var/old_cache_key = cache_key
	cache_key = get_cache_key(plating_color, stripe_color, neighbor_stripe)
	if(!(old_cache_key == cache_key))

		var/potential_overlays = GLOB.wall_overlays_cache[cache_key]
		if(potential_overlays)
			overlays = potential_overlays
			if(color)
				remove_atom_colour(color, FIXED_COLOUR_PRIORITY)
			color = plating_color
			add_atom_colour(color, FIXED_COLOUR_PRIORITY)
		else
			if(color)
				remove_atom_colour(color, FIXED_COLOUR_PRIORITY)
			color = plating_color
			add_atom_colour(color, FIXED_COLOUR_PRIORITY)
			//Updating the unmanaged wall overlays (unmanaged for optimisations)
			overlays.len = 0
			var/list/new_overlays = update_changed_overlays(plating_color, stripe_color, neighbor_stripe)
			overlays = new_overlays
			GLOB.wall_overlays_cache[cache_key] = new_overlays

	//And letting anything else that may want to render on the wall to work (ie components)
	return ..()

/turf/closed/examine(mob/user)
	. += ..()
	if(wall_paint)
		. += span_notice("It's coated with a <font color=[wall_paint]>layer of paint</font>.")
	if(stripe_paint)
		. += span_notice("It has a <font color=[stripe_paint]>painted stripe</font> around its base.")

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/proc/paint_wall(new_paint)
	wall_paint = new_paint
	update_appearance()

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/proc/paint_stripe(new_paint)
	stripe_paint = new_paint
	update_appearance()

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/proc/set_wall_information(plating_mat, new_paint, new_stripe_paint)
	wall_paint = new_paint
	stripe_paint = new_stripe_paint
	set_materials(plating_mat)

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/proc/set_materials(obj/item/stack/plating_mat)
	if(!plating_mat)
		CRASH("Something tried to set wall plating to null!")

	var/datum/material/plating_mat_ref
	if(plating_mat && initial(plating_mat.material_type))
		plating_mat_ref = GET_MATERIAL_REF(initial(plating_mat.material_type))
	else
		plating_mat_ref = material_cache[plating_mat]
		if(!plating_mat_ref && plating_mat_ref != FALSE)
			var/obj/thing = new plating_mat // Fuck I hate this fucking why byond
			if(thing.custom_materials?.len && thing.custom_materials[1]) // Hail mary for weird walls that don't use normal mats.
				plating_mat_ref = GET_MATERIAL_REF(thing.custom_materials[1])
				material_cache[plating_mat] = plating_mat_ref
			else
				custom_wall = TRUE
				custom_walls |= type
				return
		else
			custom_wall = TRUE
			custom_walls |= type
			return

	if(!plating_mat_ref)
		stack_trace("[type] has no valid material!")
		return

	// Lazy code, cause I CBA going through all the subtypes.
	base_icon_state = "wall"
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	smoothing_groups = SMOOTH_GROUP_WALLS

	icon = plating_mat_ref.wall_icon
	stripe_icon = plating_mat_ref.wall_stripe_icon

	shiny_wall = plating_mat_ref.wall_shine
	if(shiny_wall)
		shiny_wall_icon = plating_mat_ref.wall_shine_icon
		shiny_stripe_icon = plating_mat_ref.wall_stripe_shine_icon

	material_color = plating_mat_ref.wall_color || plating_mat_ref.color || plating_mat_ref.greyscale_color

	name = "[plating_mat_ref.name] [plating_mat_ref.wall_name]"
	desc = "It seems to be a section of hull plated with [plating_mat_ref.name]."

	matset_name = name

	update_appearance(UPDATE_ICON)

/turf/closed/proc/get_cache_key(plating_color, stripe_color, neighbor_stripe)
	return "[icon]:[smoothing_junction]:[plating_color]:[stripe_icon]:[stripe_color]:[neighbor_stripe]:[shiny_wall]"

/turf/closed/proc/update_changed_overlays(plating_color, stripe_color, neighbor_stripe)
	var/list/new_overlays = list()
	if(shiny_wall)
		var/image/shine = image(shiny_wall_icon, "shine-[smoothing_junction]")
		shine.appearance_flags = RESET_COLOR
		new_overlays += shine

	var/image/smoothed_stripe = image(stripe_icon, "stripe-[smoothing_junction]")
	smoothed_stripe.appearance_flags = RESET_COLOR
	smoothed_stripe.color = stripe_color
	new_overlays += smoothed_stripe

	if(shiny_wall)
		var/image/stripe_shine = image(shiny_stripe_icon, "shine-[smoothing_junction]")
		stripe_shine.appearance_flags = RESET_COLOR
		new_overlays += stripe_shine

	if(neighbor_stripe)
		var/image/neighb_stripe_overlay = image('modular_zubbers/icons/turf/walls/neighbor_stripe.dmi', "stripe-[neighbor_stripe]")
		neighb_stripe_overlay.appearance_flags = RESET_COLOR
		neighb_stripe_overlay.color = stripe_color
		new_overlays += neighb_stripe_overlay
		if(shiny_wall)
			var/image/shine = image('modular_zubbers/icons/turf/walls/neighbor_stripe_shine.dmi', "shine-[neighbor_stripe]")
			shine.appearance_flags = RESET_COLOR
			new_overlays += shine

	return new_overlays
