/obj/item/gun/ballistic/shotgun/bulldog
	burst_size = 1
	fire_delay = 1
	burst_fire_selection = FALSE

/obj/item/gun/ballistic/shotgun/bulldog/Initialize(mapload)
	actions_types -= /datum/action/item_action/toggle_firemode
	. = ..()
