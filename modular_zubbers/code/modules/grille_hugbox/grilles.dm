//This makes it so shocked grilles are not possible to spawn, unless there is a window on it.
/obj/structure/grille/
	var/maploaded = FALSE

/obj/structure/grille/Initialize(mapload)
	..()
	maploaded = mapload
	return INITIALIZE_HINT_LATELOAD

/obj/structure/grille/LateInitialize()
	if(maploaded && density)
		var/turf/T = get_turf(src)
		if(T.get_cable_node() && !(locate(/obj/structure/window/) in T)) //Check for cable node and window.
			take_damage(max_integrity * 0.9)
			new /obj/item/storage/box/hug(T)
