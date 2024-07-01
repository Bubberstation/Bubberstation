/obj/structure/sink/supply_layer/Initialize(mapload, ndir = 0, has_water_reclaimer = null)
	. = ..()
	SEND_SIGNAL(src, COMSIG_MOVABLE_CHANGE_DUCT_LAYER, new_layer = FOURTH_DUCT_LAYER)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sink/supply_layer, (-14))

/obj/structure/sink/kitchen/supply_layer/Initialize(mapload, ndir = 0, has_water_reclaimer = null)
	. = ..()
	SEND_SIGNAL(src, COMSIG_MOVABLE_CHANGE_DUCT_LAYER, new_layer = FOURTH_DUCT_LAYER)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sink/kitchen/supply_layer, (-16))
