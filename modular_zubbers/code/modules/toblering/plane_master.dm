/atom/movable/screen/plane_master/hidden_walls
	name = "Hidden Walls"
	documentation = "Holds portions of walls that are not typically visible.\
		<br>Alpha'd up if that isn't the case, so basically if you have SEE_TURFS or an equivilant"
	plane = HIDDEN_WALL_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD)

/atom/movable/screen/plane_master/hidden_walls/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	// add_relay_to(GET_NEW_PLANE(EMISSIVE_RENDER_PLATE, offset), relay_layer = EMISSIVE_FRILL_LAYER, relay_color = GLOB.em_block_color)

/atom/movable/screen/plane_master/hidden_walls/show_to(mob/mymob)
	. = ..()
	if(!.)
		return

	handle_sight(mymob, mymob.sight, NONE)
	RegisterSignal(mymob, COMSIG_MOB_SIGHT_CHANGE, PROC_REF(handle_sight), override = TRUE)

/atom/movable/screen/plane_master/hidden_walls/hide_from(mob/oldmob)
	. = ..()
	UnregisterSignal(oldmob, COMSIG_MOB_SIGHT_CHANGE)

/atom/movable/screen/plane_master/hidden_walls/proc/handle_sight(mob/source, new_sight, old_sight)
	if(new_sight & (SEE_TURFS|SEE_THRU))
		enable_alpha()
	else
		disable_alpha()
