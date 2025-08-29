/obj/structure/flagpole
	name = "flagpole"
	desc = "Don't stick your tongue on it."
	icon = 'local/icons/obj/structures/flagpole.dmi'
	icon_state = "flagpole"
	density = TRUE
	anchored = TRUE
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	//Buckling
	can_buckle = TRUE
	buckle_requires_restraints = TRUE

/obj/structure/flagpole/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seethrough, get_seethrough_map())

///Return a see_through_map, examples in seethrough.dm
/obj/structure/flagpole/proc/get_seethrough_map()
	return SEE_THROUGH_MAP_DEFAULT
