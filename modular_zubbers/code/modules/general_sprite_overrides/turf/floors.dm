/turf/open/floor
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

/turf/open/floor/catwalk_floor
	icon = 'modular_zubbers/icons/turf/floors/catwalk_plating.dmi'

/turf/open/indestructible
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

/turf/open/indestructible/cobble
	name = "cobblestone path"
	desc = "A simple but beautiful path made of various sized stones."
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'
	icon_state = "cobble"
	baseturfs = /turf/open/indestructible/cobble
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE

/turf/open/indestructible/cobble/side
	icon_state = "cobble_side"

/turf/open/indestructible/cobble/corner
	icon_state = "cobble_corner"

/turf/open/floor/plating/reinforced
	icon = 'icons/turf/floors.dmi'

/turf/open/floor/iron/white/textured_large/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/circuit
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

/turf/open/floor/light/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/engine/cult
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

/obj/effect/cult_turf
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

/turf/open/floor/cult/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

// TRAM FLOORS

/turf/open/floor/noslip/tram
	icon = 'modular_zubbers/icons/turf/floors/tram.dmi'

/turf/open/floor/tram
	icon = 'modular_zubbers/icons/turf/floors/tram.dmi'

/turf/open/floor/tram/plate
	icon = 'modular_zubbers/icons/turf/floors/tram.dmi'

/turf/open/indestructible/tram
	icon = 'modular_zubbers/icons/turf/floors/tram.dmi'

/turf/open/floor/tram/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/tram/tram_platform/burnt_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/tram/plate/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/tram/plate/burnt_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/tram/plate/energized/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/tram/plate/energized/burnt_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

// LIVING FLOORS

/mob/living/basic/living_floor
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

// OBJECT BASED
// I know these are objects but it's more organized if we keep specific ones here.

/obj/item/stack/tile
	icon = 'modular_zubbers/icons/obj/tiles.dmi'

/obj/item/stack/tile/mineral/titanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/titanium,
		/obj/item/stack/tile/mineral/titanium/yellow,
		/obj/item/stack/tile/mineral/titanium/blue,
		/obj/item/stack/tile/mineral/titanium/white,
		/obj/item/stack/tile/mineral/titanium/purple,
		/obj/item/stack/tile/mineral/titanium/tiled,
		/obj/item/stack/tile/mineral/titanium/tiled/yellow,
		/obj/item/stack/tile/mineral/titanium/tiled/blue,
		/obj/item/stack/tile/mineral/titanium/tiled/white,
		/obj/item/stack/tile/mineral/titanium/tiled/purple,
		/obj/item/stack/tile/mineral/titanium/cargo,
		/obj/item/stack/tile/mineral/titanium/cargo/mainta,
		/obj/item/stack/tile/mineral/titanium/cargo/maintb,
		/obj/item/stack/tile/mineral/titanium/cargo/maintc,
		/obj/item/stack/tile/mineral/titanium/exploration,
		/obj/item/stack/tile/mineral/titanium/exploration/flat,
		/obj/item/stack/tile/mineral/titanium/exploration/flat_textured,
		/obj/item/stack/tile/mineral/titanium/exploration/hazard,
		/obj/item/stack/tile/mineral/titanium/shuttle_arrivals,
		/obj/item/stack/tile/mineral/titanium/shuttle_evac,
		)

/obj/item/stack/tile/mineral/bananium
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)

/obj/structure/broken_flooring
	icon = 'modular_zubbers/icons/obj/fluff/brokentiling.dmi'

/obj/structure/transport/linear/public
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

/obj/structure/thermoplastic
	icon = 'modular_zubbers/icons/turf/floors/tram.dmi'
