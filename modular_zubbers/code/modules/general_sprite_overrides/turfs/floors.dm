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

/turf/open/floor/bamboo
	icon = 'modular_zubbers/icons/turf/floors/bamboo_mat.dmi'

/turf/open/floor/bamboo/tatami
	icon = 'modular_zubbers/icons/turf/floors/floor_variations.dmi'

/turf/open/floor/bamboo/tatami/purple
	icon = 'modular_zubbers/icons/turf/floors/floor_variations.dmi'

/turf/open/floor/bamboo/tatami/black
	icon = 'modular_zubbers/icons/turf/floors/floor_variations.dmi'

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

// -> Base TG TURF types that didn't get resprites <-
// KILL ME
// I HATE THIS SO MUCH
/turf/open/floor/iron/recharge_floor/dark
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/iron/recharge_floor/white
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/iron/recharge_floor/smooth
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/plasma/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/gold/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/gold/sun
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/silver/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/silver/moon
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/bananium/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/diamond/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/uranium/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/bluespace
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/bluespace/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/telecrystal
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/telecrystal/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/adamantine
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/adamantine/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/metal_hydrogen
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/metal_hydrogen/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/runite
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/runite/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/mythril
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/mineral/mythril/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/plastic/puzzle
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/hauntium
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/hauntium/tiled
	icon = 'icons/turf/floors.dmi'
/turf/open/floor/sandstone
	icon = 'icons/turf/floors.dmi'

// LIVING FLOORS

/mob/living/basic/living_floor
	icon = 'modular_zubbers/icons/turf/floors/floors.dmi'

// OBJECT BASED
// I know these are objects but it's more organized if we keep specific ones here.

/obj/item/stack/tile
	icon = 'modular_zubbers/icons/obj/tiles.dmi'

/obj/item/stack/light_w
	icon = 'modular_zubbers/icons/obj/tiles.dmi'

// -> Base TG STACK types that didn't get resprites <-
// KILL ME
// I HATE THIS SO MUCH
/obj/item/stack/tile/iron/recharge_floor/dark
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/iron/recharge_floor/white
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/iron/recharge_floor/smooth
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/plasma/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/uranium/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/gold/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/gold/sun
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/silver/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/silver/moon
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/diamond/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/bananium/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/bluespace
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/bluespace/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/telecrystal
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/telecrystal/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/adamantine
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/adamantine/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/metal_hydrogen
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/metal_hydrogen/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/runite
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/runite/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/mythril
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/mythril/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/mineral/sandstone
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/bamboo/planks
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/carpet/bear
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/carpet/polar_bear
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/carpet/moth
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/carpet/goliath
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/carpet/carp
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/carpet/lizard
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/carpet/human
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/plastic/puzzle
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/hauntium
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/hauntium/tiled
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/bronze/window
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/cult/window
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/glass/titanium
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/glass/plastitanium
	icon = 'icons/obj/tiles.dmi'
/obj/item/stack/tile/stained_glass // This one has subtypes btw
	icon = 'icons/obj/tiles.dmi'


// This isn't under stack/tile..... Look at you, light_w, you get an entire two lines to yourself!
// Enjoy it, because people only craft you out of mistake.

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
