// Bonfires but with a grill pre-attached

/obj/structure/bonfire/grill_pre_attached

/obj/structure/bonfire/grill_pre_attached/Initialize(mapload)
	. = ..()

	grill = TRUE
	add_overlay("bonfire_grill")

// Dirt but icebox and also farmable

/turf/open/misc/dirt/icemoon
	baseturfs = /turf/open/openspace/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/misc/dirt/icemoon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_farm, set_plant = TRUE)

/turf/open/water/hot_spring/icemoon_atmos
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

// The area

/area/ruin/unpowered/primitive_catgirl_den
	name = "\improper Icewalker Camp"
