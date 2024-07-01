/obj/machinery/shower/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	if(do_after(user, 3 SECONDS, src))
		reagents.remove_all(reagents.total_volume)
		balloon_alert(user, "reservoir emptied")

/obj/machinery/shower/supply_layer/Initialize(mapload, ndir = 0, has_water_reclaimer = null)
	. = ..()
	SEND_SIGNAL(src, COMSIG_MOVABLE_CHANGE_DUCT_LAYER, new_layer = FOURTH_DUCT_LAYER)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/shower/supply_layer, (-16))
