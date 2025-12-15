/obj/item/stack/tile/iron/elevated
	name = "elevated floor tile"
	singular_name = "elevated floor tile"
	icon = 'modular_zubbers/icons/obj/tiles_misc.dmi'
	icon_state = "elevated_plasteel"
	turf_type = /turf/open/floor/iron/elevated

/obj/item/stack/tile/iron/lowered
	name = "lowered floor tile"
	singular_name = "lowered floor tile"
	icon = 'modular_zubbers/icons/obj/tiles_misc.dmi'
	icon_state = "lowered_plasteel"
	turf_type = /turf/open/floor/iron/lowered

/obj/item/stack/tile/iron/pool
	name = "pool floor tile"
	singular_name = "pool floor tile"
	icon = 'modular_zubbers/icons/obj/tiles_misc.dmi'
	icon_state = "pool"
	turf_type = /turf/open/floor/iron/pool
	tile_reskin_types = list(
		/obj/item/stack/tile/iron/pool,
		/obj/item/stack/tile/iron/pool/cobble,
		/obj/item/stack/tile/iron/pool/cobble/side,
		/obj/item/stack/tile/iron/pool/cobble/corner
	)

/obj/item/stack/tile/iron/pool/cobble
	name = "cobblestone pool floor tile"
	singular_name = "cobblestone pool floor tile"
	icon_state = "cobble"
	turf_type = /turf/open/floor/iron/pool/cobble

/obj/item/stack/tile/iron/pool/cobble/side
	name = "cobblestone side pool floor tile"
	singular_name = "cobblestone side pool floor tile"
	icon_state = "cobble_side"
	turf_type = /turf/open/floor/iron/pool/cobble/side
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/pool/cobble/corner
	name = "cobblestone corner pool floor tile"
	singular_name = "cobblestone corner pool floor tile"
	icon_state = "cobble_corner"
	turf_type = /turf/open/floor/iron/pool/cobble/corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)

/turf/open/floor/iron/pool
	name = "pool floor"
	floor_tile = /obj/item/stack/tile/iron/pool
	icon = 'modular_skyrat/modules/liquids/icons/turf/pool_tile.dmi'
	base_icon_state = "pool_tile"
	icon_state = "pool_tile"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/pool/rust_heretic_act()
	return

/turf/open/floor/iron/pool/cobble
	name = "cobblestone pool floor"
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'
	base_icon_state = "cobble"
	icon_state = "cobble"
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/iron/pool/cobble/side
	base_icon_state = "cobble_side"
	icon_state = "cobble_side"

/turf/open/floor/iron/pool/cobble/corner
	base_icon_state = "cobble_corner"
	icon_state = "cobble_corner"

/turf/open/floor/iron/elevated
	name = "elevated floor"
	floor_tile = /obj/item/stack/tile/iron/elevated
	icon = 'modular_zubbers/icons/turf/floors/elevated_plasteel.dmi'
	icon_state = "elevated_plasteel-0"
	base_icon_state = "elevated_plasteel"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_ELEVATED_PLASTEEL
	canSmoothWith = SMOOTH_GROUP_ELEVATED_PLASTEEL
	layer = HIGH_TURF_LAYER
	liquid_height = 30
	turf_height = 30

/turf/open/floor/iron/elevated/rust_heretic_act()
	return

/turf/open/floor/iron/lowered
	name = "lowered floor"
	floor_tile = /obj/item/stack/tile/iron/lowered
	icon = 'modular_zubbers/icons/turf/floors/lowered_plasteel.dmi'
	icon_state = "lowered_plasteel-0"
	base_icon_state = "lowered_plasteel"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_LOWERED_PLASTEEL
	canSmoothWith = SMOOTH_GROUP_LOWERED_PLASTEEL
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/lowered/rust_heretic_act()
	return
