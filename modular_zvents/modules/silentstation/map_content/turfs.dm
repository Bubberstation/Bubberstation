/**
 *
 * 	 City walls
 */

/turf/closed/wall/city
	name = "Brick wall"
	desc = "Brick wall made of bricks"
	icon = 'modular_zvents/icons/turf/city/brick.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	explosive_resistance = 2
	rust_resistance = RUST_RESISTANCE_ABSOLUTE
	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	baseturfs = /turf/open/floor/plating
	flags_ricochet = RICOCHET_HARD
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WALLS_SHINNY
	canSmoothWith = SMOOTH_GROUP_WALLS_SHINNY
	rcd_memory = RCD_MEMORY_WALL
	can_engrave = FALSE
	hardness = 20
	slicing_duration = 20 SECONDS
	sheet_amount = 3
	girder_type = null


/turf/closed/wall/city/Initialize(mapload)
	. = ..()

/turf/closed/wall/city/lower
	icon_state = "low-0"
	base_icon_state = "low"


/turf/closed/wall/city/siding
	name = "Siding wall"
	desc = "A wall made of siding."
	icon = 'modular_zvents/icons/turf/city/siding.dmi'

/turf/closed/wall/city/siding/style

/turf/closed/wall/city/siding/style/style_1
	icon = 'modular_zvents/icons/turf/city/siding_1.dmi'

/turf/closed/wall/city/siding/style/style_2
	icon = 'modular_zvents/icons/turf/city/siding_2.dmi'

/turf/closed/wall/city/siding/style/style_2
	icon = 'modular_zvents/icons/turf/city/siding_3.dmi'

/turf/closed/wall/city/siding/red
	icon = 'modular_zvents/icons/turf/city/siding_red_1.dmi'

/turf/closed/wall/city/siding/red/style

/turf/closed/wall/city/siding/red/style/style_1
	icon = 'modular_zvents/icons/turf/city/siding_red_1.dmi'

/turf/closed/wall/city/siding/red/style/style_2
	icon = 'modular_zvents/icons/turf/city/siding_red_2.dmi'

/turf/closed/wall/city/siding/red/style/style_3
	icon = 'modular_zvents/icons/turf/city/siding_red_3.dmi'

/**
 *
 * 	 City turfs
 */

/turf/open/misc/asphalt
	name = "Asphalt"
	desc = "Regular asphalt"
	icon = 'modular_zvents/icons/turf/asphalt.dmi'
	icon_state = "roof-0"
	base_icon_state = "roof"

	flags_1 = NO_SCREENTIPS_1 | CAN_BE_DIRTY_1
	turf_flags = IS_SOLID | NO_RUST

	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

	underfloor_accessibility = UNDERFLOOR_INTERACTABLE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_FLOOR_ASPHALT
	canSmoothWith = SMOOTH_GROUP_FLOOR_ASPHALT + SMOOTH_GROUP_OPEN_FLOOR

	thermal_conductivity = 0.02
	heat_capacity = 20000
	tiled_turf = TRUE

/turf/open/misc/asphalt/no_border
	icon = 'modular_zvents/icons/turf/asphalt_noborder.dmi'
