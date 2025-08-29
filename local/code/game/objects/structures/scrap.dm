/obj/structure/scrap
	name = "scrap pile"
	desc = "A pile of debris, thrown in a loose pile."
	icon = 'local/icons/obj/scrap.dmi'
	icon_state = "scrap"
	anchored = TRUE
	var/list/ways = list("pokes around in", "searches", "scours", "digs through", "rummages through", "goes through","picks through")

/obj/structure/scrap/examine(mob/user)
	.=..()
	. += span_notice("Some cutting equipment would be ideal to cut through this for valuables, though a shovel will work in a pinch.")

/obj/structure/scrap/attackby(obj/item/tool, mob/user, params)
	// We check here if we have a shovel, OR a valid welding tool.
	if(tool.tool_behaviour == TOOL_SHOVEL || tool.tool_behaviour == TOOL_WELDER && tool.tool_start_check(user, amount=0))
		user.visible_message(span_notice("[user] [pick(ways)] \the [src]..."))
		// If the tool works, we spawn loot and delete the scrap pile.
		if(tool.use_tool(src, user, 150, volume = 100))
			user.visible_message(span_notice("[user] [pick(ways)] what remains of \the [src]."))
			var/list/trash_types = subtypesof(/obj/item/trash)
			if(prob(85)) // Not guaranteed to find anything good; but you're very likely to.
				new /obj/item/scrap_chunk(get_turf(src))
			else new /obj/item/stack/ore/glass(get_turf(src))
			for(var/i in 1 to 3)
				var/trash = pick_n_take(trash_types)
				new trash(get_turf(src))
			qdel(src)

/obj/structure/scrap/falls_when_spawned/Initialize(mapload)
	. = ..()
	fall_animation()

/obj/structure/scrap/falls_when_spawned/proc/fall_animation()
	pixel_x = rand(-150, 150)
	pixel_y = 500
	var/potential_seconds = rand(2, 4) SECONDS
	animate(src, pixel_y = initial(pixel_y), pixel_x = initial(pixel_x), time = potential_seconds)
	addtimer(CALLBACK(src, PROC_REF(end_fall)), potential_seconds)

/obj/structure/scrap/falls_when_spawned/proc/end_fall()
	for(var/atom/movable/potential_am in loc)
		if(potential_am != src)
			potential_am.ex_act(1)

	for(var/mob/living/M in oviewers(6, src))
		shake_camera(M, 2, 2)
	playsound(loc, 'sound/effects/meteorimpact.ogg', 50, 1)
