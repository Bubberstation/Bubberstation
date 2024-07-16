//This makes it so shocked grilles are not possible to spawn, unless there is a window on it.

GLOBAL_LIST_INIT(grille_connected_directions, list(NORTH, EAST, SOUTH, WEST))

/obj/structure/grille/
	var/maploaded = FALSE

/obj/structure/grille/Initialize(mapload)
	..()
	maploaded = mapload
	return INITIALIZE_HINT_LATELOAD

/obj/structure/grille/LateInitialize()

	if(!maploaded || !density) //Only apply to maploaded grilles.
		return

	var/turf/our_turf = get_turf(src)

	if(!is_station_level(our_turf.z) || !our_turf.get_cable_node()) //Do we have a cable node attached?
		return

	if(locate(/obj/structure/window) in our_turf) //Are we attached to a window?
		return

	for(var/direction in grille_connected_directions) //Are we next to a grille turf?
		var/turf/adjacent_turf = get_step(our_turf,direction)
		if(locate(/obj/structure/grille/) in adjacent_turf))
			return

	take_damage(max_integrity * 0.9)
	new /obj/item/storage/box/hug(T)
