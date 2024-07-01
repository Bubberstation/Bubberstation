/turf/open/floor/iron/solarpanel/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/iron/solarpanel/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/misc/ocean/rock
	name = "rock"
	desc = "Polished over centuries of undersea weather conditions and a distinct lack of light."
	baseturfs = /turf/open/misc/ocean/rock
	icon = 'local/code/modules/liquids/assets/turf/seafloor.dmi'
	icon_state = "seafloor"
	base_icon_state = "seafloor"
	rand_variants = 0

/turf/open/misc/ocean/rock/warm
	liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/warm

/turf/open/misc/ocean/rock/warm/fissure
	name = "fissure"
	desc = "A comfortable, warm tempature eminates from these - followed immediately after by toxic chemicals in liquid or gaseous forms; but warmth all the same!"
	icon = 'local/code/modules/liquids/assets/turf/fissure.dmi'
	icon_state = "fissure-0"
	base_icon_state = "fissure"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_FISSURE
	canSmoothWith = SMOOTH_GROUP_FISSURE
	light_range = 3
	light_color = LIGHT_COLOR_LAVA

/turf/open/misc/ocean
	gender = PLURAL
	name = "ocean sand"
	desc = "If you can't escape sandstorms underwater, is anywhere safe?"
	baseturfs = /turf/open/misc/ocean
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	planetary_atmos = TRUE
	var/rand_variants = 12
	var/rand_chance = 30
	var/liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean

/turf/open/misc/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(liquid_type, src)
	new_immmutable.add_turf(src)

	if(rand_variants && prob(rand_chance))
		var/random = rand(1,rand_variants)
		icon_state = "[icon_state][random]"
		base_icon_state = "[icon_state][random]"

/turf/open/misc/ocean/rock/medium
	icon_state = "seafloor_med"
	base_icon_state = "seafloor_med"
	baseturfs = /turf/open/misc/ocean/rock/medium

/turf/open/misc/ocean/rock/heavy
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/ocean/rock/heavy

/turf/open/floor/engine/hull/reinforced/ocean
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	temperature = T20C
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/floor/engine/hull/reinforced/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/glass/reinforced/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/glass/reinforced/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/engine/hull/ocean
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	temperature = T20C
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/floor/engine/hull/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)
