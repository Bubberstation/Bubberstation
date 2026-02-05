/*
/area/shuttle
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
*/

/obj/docking_port/mobile/arrivals

/turf/closed/wall/mineral/titanium/shuttle_wall
	name = "shuttle wall"
	desc = "A light-weight titanium wall used in shuttles."
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/pod.dmi'
	icon_state = ""
	base_icon_state = ""
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null

/turf/closed/wall/mineral/titanium/shuttle_wall/AfterChange(flags, oldType)
	. = ..()
	// Manually add space underlay, in a way similar to turf_z_transparency,
	// but we actually show the old content of the same z-level, as desired for shuttles

	var/turf/underturf_path

	// Grab previous turf icon
	if(!ispath(oldType, /turf/closed/wall/mineral/titanium/shuttle_wall))
		underturf_path = oldType
	else
		// Else use whatever SSmapping tells us, like transparent open tiles do
		underturf_path = SSmapping.level_trait(z, ZTRAIT_BASETURF) || /turf/open/space

	var/mutable_appearance/underlay_appearance = mutable_appearance(
		initial(underturf_path.icon),
		initial(underturf_path.icon_state),
		offset_spokesman = src,
		layer = LOW_FLOOR_LAYER - 0.02,
		plane = FLOOR_PLANE)
	underlay_appearance.appearance_flags = RESET_ALPHA | RESET_COLOR
	underlays += underlay_appearance

/turf/closed/wall/mineral/titanium/shuttle_wall/window
	opacity = FALSE

/*
*	POD
*/

/turf/closed/wall/mineral/titanium/shuttle_wall/pod
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/pod.dmi'

/turf/closed/wall/mineral/titanium/shuttle_wall/window/pod
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/pod.dmi'
	icon_state = "3,1"

/*
*	FERRY
*/

/turf/closed/wall/mineral/titanium/shuttle_wall/ferry
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/erokez.dmi'
	icon_state = "18,2"

/turf/closed/wall/mineral/titanium/shuttle_wall/window/ferry
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/erokez.dmi'
	icon_state = "18,2"

/turf/open/floor/iron/shuttle/ferry
	name = "shuttle floor"
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/erokez.dmi'
	icon_state = "floor1"

/turf/open/floor/iron/shuttle/ferry/airless
	initial_gas_mix = AIRLESS_ATMOS

/*
*	EVAC
*/

/turf/closed/wall/mineral/titanium/shuttle_wall/evac
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/evac_shuttle.dmi'
	icon_state = "9,1"

/turf/closed/wall/mineral/titanium/shuttle_wall/window/evac
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/evac_shuttle.dmi'
	icon_state = "9,1"

/turf/open/floor/iron/shuttle/evac
	name = "shuttle floor"
	floor_tile = /obj/item/stack/tile/mineral/titanium/shuttle_evac
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/evac_shuttle.dmi'
	icon_state = "floor"

/turf/open/floor/iron/shuttle/evac/airless
	initial_gas_mix = AIRLESS_ATMOS

/*
*	ARRIVALS
*/

/turf/closed/wall/mineral/titanium/shuttle_wall/arrivals
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/wagon.dmi'
	icon_state = "3,1"

/turf/closed/wall/mineral/titanium/shuttle_wall/window/arrivals
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/wagon.dmi'
	icon_state = "3,1"

/turf/open/floor/iron/shuttle/arrivals
	name = "shuttle floor"
	floor_tile = /obj/item/stack/tile/mineral/titanium/shuttle_arrivals
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/wagon.dmi'
	icon_state = "floor"

/turf/open/floor/iron/shuttle/arrivals/airless
	initial_gas_mix = AIRLESS_ATMOS

/*
*	CARGO
*/

/turf/closed/wall/mineral/titanium/shuttle_wall/cargo
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/cargo.dmi'
	icon_state = "3,1"

/turf/closed/wall/mineral/titanium/shuttle_wall/window/cargo
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/cargo.dmi'
	icon_state = "3,1"

/turf/open/floor/iron/shuttle/cargo
	name = "shuttle floor"
	floor_tile = /obj/item/stack/tile/mineral/titanium/cargo
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/cargo.dmi'
	icon_state = "floor"
	base_icon_state = "floor"

/turf/open/floor/iron/shuttle/cargo/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/iron/shuttle/cargo/cargo_mainta
	floor_tile = /obj/item/stack/tile/mineral/titanium/cargo/mainta
	icon_state = "floor_mainta"
	base_icon_state = "floor_mainta"

/turf/open/floor/iron/shuttle/cargo/cargo_maintb
	floor_tile = /obj/item/stack/tile/mineral/titanium/cargo/maintb
	icon_state = "floor_maintb"
	base_icon_state = "floor_maintb"

/turf/open/floor/iron/shuttle/cargo/cargo_maintc
	floor_tile = /obj/item/stack/tile/mineral/titanium/cargo/maintc
	icon_state = "floor_maintc"
	base_icon_state = "floor_maintc"

/*
*	MINING
*/

/turf/closed/wall/mineral/titanium/shuttle_wall/mining
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/mining.dmi'

/turf/closed/wall/mineral/titanium/shuttle_wall/window/mining
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/mining.dmi'

/turf/closed/wall/mineral/titanium/shuttle_wall/mining_large
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/mining_large.dmi'
	icon_state = "2,2"
	dir = NORTH

/turf/closed/wall/mineral/titanium/shuttle_wall/window/mining_large
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/mining_large.dmi'
	icon_state = "6,3"
	dir = NORTH

/turf/closed/wall/mineral/titanium/shuttle_wall/mining_labor
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/mining_labor.dmi'
	icon_state = "4,6"
	dir = NORTH

/turf/closed/wall/mineral/titanium/shuttle_wall/window/mining_labor
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/mining_labor.dmi'
	icon_state = "4,4"
	dir = NORTH

/*
*	MINING/RND/EXPLORATION FLOORS
*/

/turf/open/floor/iron/shuttle/exploration
	name = "shuttle floor"
	floor_tile = /obj/item/stack/tile/mineral/titanium/exploration
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/exploration_floor.dmi'
	icon_state = "oside"
	base_icon_state = "oside"

/turf/open/floor/iron/shuttle/exploration/uside
	icon_state = "uside"

/turf/open/floor/iron/shuttle/exploration/corner
	icon_state = "corner"

/turf/open/floor/iron/shuttle/exploration/side
	icon_state = "side"

/turf/open/floor/iron/shuttle/exploration/corner_invcorner
	icon_state = "corner_icorner"

/turf/open/floor/iron/shuttle/exploration/adjinvcorner
	icon_state = "adj_icorner"

/turf/open/floor/iron/shuttle/exploration/oppinvcorner
	icon_state = "opp_icorner"

/turf/open/floor/iron/shuttle/exploration/invertcorner
	icon_state = "icorner"

/turf/open/floor/iron/shuttle/exploration/doubleinvertcorner
	icon_state = "double_icorner"

/turf/open/floor/iron/shuttle/exploration/tripleinvertcorner
	icon_state = "tri_icorner"

/turf/open/floor/iron/shuttle/exploration/doubleside
	icon_state = "double_side"

/turf/open/floor/iron/shuttle/exploration/quadinvertcorner
	icon_state = "4icorner"

/turf/open/floor/iron/shuttle/exploration/doubleinvertcorner_side
	icon_state = "double_icorner_side"

/turf/open/floor/iron/shuttle/exploration/invertcorner_side
	icon_state = "side_icorner"

/turf/open/floor/iron/shuttle/exploration/invertcorner_side_flipped
	icon_state = "side_icorner_f"

/turf/open/floor/iron/shuttle/exploration/blanktile
	icon_state = "blank"

/turf/open/floor/iron/shuttle/exploration/flat
	floor_tile = /obj/item/stack/tile/mineral/titanium/exploration/flat
	icon_state = "flat"
	base_icon_state = "flat"

/turf/open/floor/iron/shuttle/exploration/flat/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/iron/shuttle/exploration/textured_flat
	floor_tile = /obj/item/stack/tile/mineral/titanium/exploration/flat_textured
	icon_state = "flattexture"
	base_icon_state = "flattexture"

/turf/open/floor/iron/shuttle/exploration/textured_flat/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/iron/shuttle/exploration/equipmentrail1
	icon_state = "rail1"

/turf/open/floor/iron/shuttle/exploration/equipmentrail2
	icon_state = "rail2"

/turf/open/floor/iron/shuttle/exploration/equipmentrail3
	icon_state = "rail3"

/turf/open/floor/iron/shuttle/exploration/hazard
	floor_tile = /obj/item/stack/tile/mineral/titanium/exploration/hazard
	icon_state = "hazard"
	base_icon_state = "hazard"

/turf/open/floor/iron/shuttle/exploration/hazard/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/iron/shuttle/exploration/smooth
	name = "shuttle floor"
	icon = 'modular_zubbers/icons/turf/floors/exploration_floor.dmi'
	icon_state = "exploration-0"
	base_icon_state = "exploration"
	floor_tile = /obj/item/stack/tile/mineral/titanium/exploration
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_EXPLORATION_FLOOR
	canSmoothWith = SMOOTH_GROUP_EXPLORATION_FLOOR

/*
*	TILE STACKS
*/

/obj/item/stack/tile/mineral/titanium/cargo
	name = "cargo shuttle tile"
	singular_name = "cargo shuttle floor tile"
	desc = "Utilitarian titanium floor tiles, used for cargo shuttles."
	icon = 'modular_zubbers/icons/obj/tiles_misc.dmi'
	icon_state = "cargo"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/iron/shuttle/cargo
	mineralType = "titanium"
	merge_type = /obj/item/stack/tile/mineral/titanium/cargo

/obj/item/stack/tile/mineral/titanium/cargo/mainta
	name = "cargo shuttle charger A tile"
	singular_name = "cargo shuttle charger A floor tile"
	icon_state = "cargo_mainta"
	turf_type = /turf/open/floor/iron/shuttle/cargo/cargo_mainta
	merge_type = /obj/item/stack/tile/mineral/titanium/cargo/mainta
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/mineral/titanium/cargo/maintb
	name = "cargo shuttle charger B tile"
	singular_name = "cargo shuttle charger B floor tile"
	icon_state = "cargo_maintb"
	turf_type = /turf/open/floor/iron/shuttle/cargo/cargo_maintb
	merge_type = /obj/item/stack/tile/mineral/titanium/cargo/maintb
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/mineral/titanium/cargo/maintc
	name = "cargo shuttle edge tile"
	singular_name = "cargo shuttle edge floor tile"
	icon_state = "cargo_maintc"
	turf_type = /turf/open/floor/iron/shuttle/cargo/cargo_maintc
	merge_type = /obj/item/stack/tile/mineral/titanium/cargo/maintc
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)

/obj/item/stack/tile/mineral/titanium/exploration
	name = "mining shuttle tile"
	singular_name = "mining shuttle floor tile"
	desc = "rugged titanium floor tiles, used for mining shuttles."
	icon = 'modular_zubbers/icons/obj/tiles_misc.dmi'
	icon_state = "exploration"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/iron/shuttle/exploration/smooth
	mineralType = "titanium"
	merge_type = /obj/item/stack/tile/mineral/titanium/exploration

/obj/item/stack/tile/mineral/titanium/exploration/flat
	name = "flat mining shuttle tile"
	singular_name = "flat mining shuttle floor tile"
	icon_state = "exploration_flat"
	turf_type = /turf/open/floor/iron/shuttle/exploration/flat
	merge_type = /obj/item/stack/tile/mineral/titanium/exploration/flat

/obj/item/stack/tile/mineral/titanium/exploration/flat_textured
	name = "textured mining shuttle tile"
	singular_name = "textured mining shuttle floor tile"
	icon_state = "exploration_flat_textured"
	turf_type = /turf/open/floor/iron/shuttle/exploration/textured_flat
	merge_type = /obj/item/stack/tile/mineral/titanium/exploration/flat_textured

/obj/item/stack/tile/mineral/titanium/exploration/hazard
	name = "hazard mining shuttle tile"
	singular_name = "hazard mining shuttle floor tile"
	icon_state = "exploration_flat_hazard"
	turf_type = /turf/open/floor/iron/shuttle/exploration/hazard
	merge_type = /obj/item/stack/tile/mineral/titanium/exploration/hazard

/obj/item/stack/tile/mineral/titanium/shuttle_arrivals
	name = "striped shuttle tile"
	singular_name = "striped shuttle floor tile"
	desc = "striped titanium floor tiles, used for shuttles."
	icon = 'modular_zubbers/icons/obj/tiles_misc.dmi'
	icon_state = "shuttle_arrivals"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/iron/shuttle/arrivals
	mineralType = "titanium"
	merge_type = /obj/item/stack/tile/mineral/titanium/shuttle_arrivals

/obj/item/stack/tile/mineral/titanium/shuttle_evac
	name = "shuttle tile"
	singular_name = "shuttle floor tile"
	desc = "striped titanium floor tiles, used for shuttles."
	icon = 'modular_zubbers/icons/obj/tiles_misc.dmi'
	icon_state = "shuttle_evac"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/iron/shuttle/evac
	mineralType = "titanium"
	merge_type = /obj/item/stack/tile/mineral/titanium/shuttle_evac
