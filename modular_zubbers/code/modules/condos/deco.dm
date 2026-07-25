/obj/structure/medieval/stone_arch
	name = "stone arch"
	desc = "A large decorative arch."
	icon = 'modular_skyrat/master_files/icons/obj/medieval/stone_arch.dmi'
	icon_state = "stone_arch"
	density = FALSE
	max_integrity = 150
	pixel_x = 0
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE

/obj/structure/medieval/stone_arch/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_SHIPPING_CONTAINER)

/obj/structure/medieval/wine_barrel
	name = "wine barrel"
	desc = "A decorative barrel laying on its side, with supposedly wine inside."
	icon = 'modular_skyrat/master_files/icons/obj/medieval/structures.dmi'
	icon_state = "wine_barrel"
	density = TRUE
	max_integrity = 150
	pixel_x = 0

/obj/structure/medieval/bed_1x2
	name = "bed"
	desc = "A luxurious bed, inviting you to rest on it, oh traveler."
	icon = 'modular_skyrat/master_files/icons/obj/medieval/structures_64x64.dmi'
	icon_state = "bed_1x2"
	layer = 2.2
	density = FALSE
	max_integrity = 150
	pixel_x = 0

/obj/structure/medieval/bed_2x2
	name = "bed"
	desc = "A luxurious bed, inviting you to rest on it, oh traveler."
	icon = 'modular_skyrat/master_files/icons/obj/medieval/structures_64x64.dmi'
	icon_state = "bed_2x2"
	layer = 2.2
	density = FALSE
	max_integrity = 150
	pixel_x = 0

/obj/structure/sink/standalone
	name = "sink"
	icon = 'modular_skyrat/master_files/icons/obj/medieval/structures.dmi'
	icon_state = "sink"

/turf/open/space/mirage
	blocks_air = TRUE
	light_power = 0
	space_lit = TRUE

