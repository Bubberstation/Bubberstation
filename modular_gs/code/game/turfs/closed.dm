// /turf/closed
// 	layer = CLOSED_TURF_LAYER
// 	opacity = 1
// 	density = TRUE
// 	blocks_air = 1
// 	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
// 	rad_insulation = RAD_MEDIUM_INSULATION


// leaving this helper for remembering vars - Sono


///////////////////////////////// GS13 CLOSED TURFS ///////////////////////////////


/turf/closed/indestructible/candy
	name = "Candy wall"
	desc = "Despite being made out of mere candy, this wall is harder than stone!"
	icon = 'modular_gs/icons/turf/walls/wall_candy.dmi'
	icon_state = "candywall"


/turf/closed/indestructible/chocolate
	name = "Chocolate wall"
	desc = "Somehow, it doesn't melt at all..."
	icon = 'modular_gs/icons/turf/walls/wall_candy.dmi'
	icon_state = "choco_wall1"

/turf/closed/indestructible/shadoww
	name = "shadow wall"
	desc = "A wall with shadow wood plating."
	icon = 'modular_gs/icons/turf/walls/shadoww_wall.dmi'
	icon_state = "shadoww"
	baseturfs = /turf/closed/indestructible/shadoww
	canSmoothWith = list(/turf/closed/wall/mineral/shadoww, /obj/structure/falsewall/shadoww, /turf/closed/indestructible/shadoww)

/turf/closed/indestructible/plaswood
	name = "plaswood wall"
	desc = "A wall with plaswood plating."
	icon = 'modular_gs/icons/turf/walls/plaswood_wall.dmi'
	icon_state = "plaswood"
	baseturfs = /turf/closed/indestructible/plaswood
	canSmoothWith = list(/turf/closed/wall/mineral/plaswood, /obj/structure/falsewall/plaswood, /turf/closed/indestructible/shadoww)

/turf/closed/indestructible/gmushroom
	name = "mushroom wall"
	desc = "A wall with mushroom plating."
	icon = 'modular_gs/icons/turf/walls/gmushroom_wall.dmi'
	icon_state = "gmushroom"
	baseturfs = /turf/closed/indestructible/gmushroom
	canSmoothWith = list(/turf/closed/wall/mineral/gmushroom, /obj/structure/falsewall/gmushroom, /turf/closed/indestructible/gmushroom)
