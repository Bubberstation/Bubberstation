//Shadow wood
/turf/open/floor/shadoww
	desc = "Stylish shadow wood."
	icon_state = "shadoww"
	floor_tile = /obj/item/stack/tile/shadoww
	broken_states = list("shadoww-broken", "shadoww-broken2", "shadoww-broken3", "shadoww-broken4", "shadoww-broken5", "shadoww-broken6", "shadoww-broken7")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/shadoww/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a few <b>screws</b> and a <b>small crack</b> visible.</span>"

/turf/open/floor/shadoww/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	return pry_tile(I, user)

/turf/open/floor/shadoww/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	if(T.turf_type == type)
		return
	var/obj/item/tool = user.is_holding_item_of_type(/obj/item/screwdriver)
	if(!tool)
		tool = user.is_holding_item_of_type(/obj/item/crowbar)
	if(!tool)
		return
	var/turf/open/floor/plating/P = pry_tile(tool, user, TRUE)
	if(!istype(P))
		return
	P.attackby(T, user, params)

/turf/open/floor/shadoww/pry_tile(obj/item/C, mob/user, silent = FALSE)
	C.play_tool_sound(src, 80)
	return remove_tile(user, silent, (C.tool_behaviour == TOOL_SCREWDRIVER))

/turf/open/floor/shadoww/remove_tile(mob/user, silent = FALSE, make_tile = TRUE, forced = FALSE)
	if(broken || burnt)
		broken = 0
		burnt = 0
		if(user && !silent)
			to_chat(user, "<span class='notice'>You remove the broken planks.</span>")
	else
		if(make_tile)
			if(user && !silent)
				to_chat(user, "<span class='notice'>You unscrew the planks.</span>")
			if(floor_tile)
				new floor_tile(src)
		else
			if(user && !silent)
				to_chat(user, "<span class='notice'>You forcefully pry off the planks, destroying them in the process.</span>")
	return make_plating()

//Mushroom wood
/turf/open/floor/gmushroom
	desc = "Stylish mushroom 'wood'."
	icon_state = "gmushroom"
	floor_tile = /obj/item/stack/tile/gmushroom
	broken_states = list("gmushroom-broken", "gmushroom-broken2", "gmushroom-broken3", "gmushroom-broken4", "gmushroom-broken5", "gmushroom-broken6", "gmushroom-broken7")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/gmushroom/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a few <b>screws</b> and a <b>small crack</b> visible.</span>"

/turf/open/floor/gmushroom/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	return pry_tile(I, user)

/turf/open/floor/gmushroom/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	if(T.turf_type == type)
		return
	var/obj/item/tool = user.is_holding_item_of_type(/obj/item/screwdriver)
	if(!tool)
		tool = user.is_holding_item_of_type(/obj/item/crowbar)
	if(!tool)
		return
	var/turf/open/floor/plating/P = pry_tile(tool, user, TRUE)
	if(!istype(P))
		return
	P.attackby(T, user, params)

/turf/open/floor/gmushroom/pry_tile(obj/item/C, mob/user, silent = FALSE)
	C.play_tool_sound(src, 80)
	return remove_tile(user, silent, (C.tool_behaviour == TOOL_SCREWDRIVER))

/turf/open/floor/gmushroom/remove_tile(mob/user, silent = FALSE, make_tile = TRUE, forced = FALSE)
	if(broken || burnt)
		broken = 0
		burnt = 0
		if(user && !silent)
			to_chat(user, "<span class='notice'>You remove the broken planks.</span>")
	else
		if(make_tile)
			if(user && !silent)
				to_chat(user, "<span class='notice'>You unscrew the planks.</span>")
			if(floor_tile)
				new floor_tile(src)
		else
			if(user && !silent)
				to_chat(user, "<span class='notice'>You forcefully pry off the planks, destroying them in the process.</span>")
	return make_plating()

//Plaswood
/turf/open/floor/plaswood
	desc = "Stylish plaswood."
	icon_state = "plaswood"
	floor_tile = /obj/item/stack/tile/plaswood
	broken_states = list("plaswood-broken", "plaswood-broken2", "plaswood-broken3", "plaswood-broken4", "plaswood-broken5", "plaswood-broken6", "plaswood-broken7")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/plaswood/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a few <b>screws</b> and a <b>small crack</b> visible.</span>"

/turf/open/floor/plaswood/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	return pry_tile(I, user)

/turf/open/floor/plaswood/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	if(T.turf_type == type)
		return
	var/obj/item/tool = user.is_holding_item_of_type(/obj/item/screwdriver)
	if(!tool)
		tool = user.is_holding_item_of_type(/obj/item/crowbar)
	if(!tool)
		return
	var/turf/open/floor/plating/P = pry_tile(tool, user, TRUE)
	if(!istype(P))
		return
	P.attackby(T, user, params)

/turf/open/floor/plaswood/pry_tile(obj/item/C, mob/user, silent = FALSE)
	C.play_tool_sound(src, 80)
	return remove_tile(user, silent, (C.tool_behaviour == TOOL_SCREWDRIVER))

/turf/open/floor/plaswood/remove_tile(mob/user, silent = FALSE, make_tile = TRUE, forced = FALSE)
	if(broken || burnt)
		broken = 0
		burnt = 0
		if(user && !silent)
			to_chat(user, "<span class='notice'>You remove the broken planks.</span>")
	else
		if(make_tile)
			if(user && !silent)
				to_chat(user, "<span class='notice'>You unscrew the planks.</span>")
			if(floor_tile)
				new floor_tile(src)
		else
			if(user && !silent)
				to_chat(user, "<span class='notice'>You forcefully pry off the planks, destroying them in the process.</span>")
	return make_plating()
