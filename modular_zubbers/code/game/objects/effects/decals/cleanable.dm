/obj/effect/decal/cleanable/cobweb/NeverShouldHaveComeHere(turf/here_turf)
	var/area/cobweb_area = get_area(here_turf)
	return (isgroundlessturf(here_turf) && (istype(cobweb_area, /area/template_noop) || istype(cobweb_area, /area/space))) && ..()

/obj/effect/decal/cleanable/cum
	icon = 'modular_zubbers/icons/effects/decals/cum.dmi'
	random_icon_states = list("cum_1", "cum_2", "cum_3")

/obj/effect/decal/cleanable/cum/femcum
	icon = 'modular_zubbers/icons/effects/decals/cum.dmi'
	random_icon_states = list("femcum_1", "femcum_2")
