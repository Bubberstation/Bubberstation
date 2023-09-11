/obj/effect/decal/cleanable/crayon/syndicate
	plane = FLOOR_PLANE
	layer = GAS_PIPE_HIDDEN_LAYER //under wires

/obj/effect/decal/cleanable/crayon/syndicate/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE_EMAG) //BUBBERS EDIT: