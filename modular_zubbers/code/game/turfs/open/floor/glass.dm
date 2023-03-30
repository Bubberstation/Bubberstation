/turf/open/floor/glass/wrench_act(mob/living/user, obj/item/I)
	to_chat(user, "<span class='notice'>You begin removing \the [src]..</span>")
	if(I.use_tool(src, user, 30, volume=80))
		if(!istype(src, /turf/open/floor/glass))
			return TRUE
		if(floor_tile)
			new floor_tile(src, 2)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return TRUE
