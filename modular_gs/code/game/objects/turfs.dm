/turf/open/floor/mineral/sandstone_floor
	name = "sandstone floor"
	icon_state = "sandstonef"
	floor_tile = /obj/item/stack/tile/mineral/sandstone
	icon = 'GainStation13/icons/turf/floors.dmi'
	icons = list("sandstonef","sandstonef_dam")

/turf/open/floor/mineral/crimsonstone_floor
	name = "crimson floor"
	icon_state = "crimsonstone"
	floor_tile = /obj/item/stack/tile/mineral/crimsonstone
	icon = 'GainStation13/icons/turf/floors.dmi'
	icons = list("crimsonstone","crimsonstone_dam")

/turf/open/floor/mineral/basaltstone_floor
	name = "basalt floor"
	icon_state = "basaltstone"
	floor_tile = /obj/item/stack/tile/mineral/basaltstone
	icon = 'GainStation13/icons/turf/floors.dmi'
	icons = list("basaltstone","basaltstone_dam")

/turf/open/floor/plaswood
	desc = "Stylish plaswood."
	icon = 'GainStation13/icons/turf/floors.dmi'
	icon_state = "plaswood"
	broken_states = list("plaswood-broken", "plaswood-broken2", "plaswood-broken3", "plaswood-broken4", "plaswood-broken5", "plaswood-broken6", "plaswood-broken7")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/concrete/
	name = "concrete"
	icon = 'GainStation13/icons/turf/floors.dmi'
	icon_state = "concrete"
	baseturfs = /turf/open/floor/plating/asteroid

/turf/open/floor/concrete/smooth
	icon = 'GainStation13/icons/turf/floors.dmi'
	icon_state = "concrete2"

/turf/open/floor/cobble/side
	icon = 'GainStation13/icons/turf/floors.dmi'
	icon_state = "cobble_side"

/turf/open/floor/cobble/corner
	icon = 'GainStation13/icons/turf/floors.dmi'
	icon_state = "cobble_corner"

/turf/open/floor/cobble
	name = "cobblestone path"
	desc = "A simple but beautiful path made of various sized stones."
	icon = 'GainStation13/icons/turf/floors.dmi'
	icon_state = "cobble"
	baseturfs = /turf/open/floor/plating/asteroid
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
