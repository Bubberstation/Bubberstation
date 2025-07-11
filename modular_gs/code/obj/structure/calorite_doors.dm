/obj/structure/mineral_door/calorite //GS13
	name = "calorite door"
	icon = 'modular_gs/icons/obj/structure/calorite_door.dmi'
	icon_state = "calorite"
	sheetType = /obj/item/stack/sheet/mineral/calorite
	max_integrity = 200
	light_range = 1
	// Sets it open by default
	density = FALSE
	door_opened = TRUE

// If you ever want to make any door like this, just simply add the component like this :3
/obj/structure/mineral_door/calorite/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/fattening_door)

	update_icon() // Updates the sprite when spawned in cause it's closed by default.

