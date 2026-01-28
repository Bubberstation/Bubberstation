/*
	Turfs
*/
/turf/open/openspace/icy_planet
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	can_build_on = FALSE
	baseturfs = /turf/open/openspace/icy_planet

/turf/open/misc/dirt/icy_planet
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/misc/dirt/icy_planet

/turf/open/misc/icy_planet
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	flags_1 = NO_SCREENTIPS_1 | CAN_BE_DIRTY_1
	turf_flags = IS_SOLID | NO_RUST | NO_RUINS
	underfloor_accessibility = UNDERFLOOR_VISIBLE

/turf/open/chasm/icy_planet
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/chasm/icy_planet



/turf/open/misc/icy_planet/snow
	gender = PLURAL
	name = "snow"
	desc = "Looks cold."
	icon = 'modular_zvents/icons/turf/snow.dmi'
	icon = 'modular_zvents/icons/turf/snow.dmi'
	baseturfs = /turf/open/misc/icy_planet/snow
	icon_state = "snow_2_1"
	base_icon_state = "snow"

	slowdown = 2
	bullet_sizzle = TRUE
	bullet_bounce_sound = null

	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

	var/deep_snow_chance = 20

/turf/open/misc/icy_planet/snow/Initialize(mapload)
	. = ..()
	// If only one state, this can be removed; pick_weight allows easy expansion
	icon_state = "snow_" + pick_weight(list(
		pick_weight(list(
			"2_1" = 5,
			"2_2" = 5,
			"2_3" = 5,
			"2_4" = 5,
			"2_5" = 5,
			"2_6" = 5,
		)) = 90,
		pick_weight(list(
			"1_1" = 5,
			"1_2" = 5,
			"1_3" = 5,
			"1_4" = 5,
			"1_5" = 5,
			"1_6" = 5,
		)) = 15
	))

	AddElement(/datum/element/diggable, /obj/item/stack/sheet/mineral/snow, 2)





/turf/open/misc/icy_planet/snow/proc/on_step(mob/living/stepper)
	// Optional: Footprint or crunch sound on step
	if(ishuman(stepper))
		var/mob/living/carbon/human/H = stepper
		if(HAS_TRAIT(H, TRAIT_LIGHT_STEP))
			return
		// playsound(src, 'sound/effects/snow_step.ogg', 50, TRUE)
		// Leave temporary footprint overlay
		// new /obj/effect/decal/cleanable/snowprint(src)


/turf/open/misc/icy_planet/snow/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(isliving(arrived))
		var/mob/living/l = arrived
		on_step(l)


/turf/open/misc/icy_planet/ice
	gender = NEUTER
	name = "ice"
	desc = "Thin, slippery ice. Watch your step."
	icon = 'icons/turf/snow.dmi'
	damaged_dmi = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/misc/icy_planet/snow
	icon_state = "ice"
	base_icon_state = "ice"

	slowdown = 1.5
	bullet_sizzle = TRUE

	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY



/turf/open/misc/icy_planet/ice/Initialize(mapload)
	. = ..()

	// Random cracks or variants
	icon_state = "ice" + pick_weight(list(
		"1" = 70,
		"cracked" = 30
	))

	air.temperature = TM70C
	AddComponent(/datum/component/slippery, min_slip_time = 4 SECONDS, max_slip_time = 8 SECONDS, floor_type = src, silent = FALSE)



// Subtype for cave floor (from frozen_caves generator)
/turf/open/misc/icy_planet/ice_cave_floor
	name = "frozen cave floor"
	desc = "A thin layer of ice over rocky ground. Echoey and cold."
	icon = 'icons/turf/snow.dmi'
	icon_state = "ice_cave"
	base_icon_state = "ice_cave"
	baseturfs = /turf/open/misc/icy_planet/ice_cave_floor

	slowdown = 1


/turf/open/misc/icy_planet/ice_cave_floor/Initialize(mapload)
	. = ..()
	air.temperature = TM90C


// Closed turf, mineral

/turf/closed/mineral/random/icy_planet
	name = "rock"
	icon = MAP_SWITCH('icons/turf/walls/icerock_wall.dmi', 'icons/turf/mining.dmi')
	base_icon_state = "icerock_wall"
	baseturfs = /turf/open/misc/icy_planet/snow
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	mineralChance = 5
	proximity_based = FALSE

/turf/closed/mineral/random/icy_planet/mineral_chances()
	return list(
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/silver = 6,
		/obj/item/stack/ore/titanium = 2,
		/obj/item/stack/ore/uranium = 1,
	)

/turf/closed/mineral/random/icy_planet/snow
	name = "snowy mountainside"
	icon = MAP_SWITCH('icons/turf/walls/mountain_wall.dmi', 'icons/turf/mining.dmi')
	icon_state = "mountainrock"
	base_icon_state = "mountain_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS


/turf/closed/mineral/random/icy_planet/cave
	name = "mountainside"
	icon = MAP_SWITCH('modular_skyrat/modules/liquids/icons/turf/smoothrocks.dmi', 'icons/turf/mining.dmi') // SKYRAT EDIT CHANGE
	icon_state = "rock"
	smoothing_groups = SMOOTH_GROUP_CLOSED_TURFS + SMOOTH_GROUP_MINERAL_WALLS
	canSmoothWith = SMOOTH_GROUP_MINERAL_WALLS
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	baseturfs = /turf/open/misc/dirt/station

/obj/effect/mapping_helpers/turf_cracks
	name = "Turf cracks (black)"
	desc = "Places black cracks overlay on the turf."
	icon = 'icons/obj/structures.dmi'
	icon_state = "damage25"


	var/crack_alpha = 255
	var/crack_blend = ICON_OVERLAY

/obj/effect/mapping_helpers/turf_cracks/Initialize(mapload)
	. = ..()
	if(!mapload)
		return

	var/turf/T = get_turf(src)
	if(!T)
		return

	var/mutable_appearance/crack = mutable_appearance('icons/obj/structures.dmi', icon_state, DAMAGE_LAYER)
	crack.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	crack.color = "#000000"
	crack.alpha = crack_alpha
	// crack.blend_mode = crack_blend

	T.add_overlay(crack)
	qdel(src)


/obj/effect/mapping_helpers/turf_cracks/light
	name = "Turf cracks – light (black)"
	icon_state = "damage25"

/obj/effect/mapping_helpers/turf_cracks/heavy
	name = "Turf cracks – heavy (black)"
	icon_state = "damage50"

/obj/effect/mapping_helpers/turf_cracks/severe
	name = "Turf cracks – severe (black)"
	icon_state = "damage75"

