/turf/open/floor/tram/guideway
	icon = 'modular_skyrat/modules/aesthetics/floors/icons/floors.dmi'
	icon_state = "elevatorshaft"
	base_icon_state = "elevatorshaft"
	floor_tile = /obj/item/stack/tile/noslip/tram/guideway
	liquid_height = -30
	turf_height = -30

/turf/open/floor/tram/guideway/wrench_act(mob/living/user, obj/item/item)
	return

/obj/item/stack/tile/noslip/tram/guideway
	name = "tram guideway"
	singular_name = "tram guideway"
	icon_state = "tile-neon"
	base_icon_state = "tile-neon"
	turf_type = /turf/open/floor/tram/guideway
