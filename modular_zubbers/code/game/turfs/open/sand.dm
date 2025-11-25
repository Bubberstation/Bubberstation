//Sand
/turf/open/misc/moonstation_sand
	name = "lunar sand"
	gender = PLURAL //fucking LIBERALS gendering my SAND oh my GOD *goes on an unhinged rant on reddit*
	desc = "Not to be confused with the legally distinct children's toy, this lunar sand is coarse and rough and gets everywhere."
	initial_gas_mix = MOONSTATION_ATMOS
	icon = 'modular_zubbers/icons/turf/lunar_sand.dmi'
	icon_state = "0,0"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/moonstation_rock
	flags_1 = NONE

/turf/open/misc/moonstation_sand/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/diggable, /obj/item/stack/ore/glass, 2, worm_chance = 3)
	icon_state = "[x % 10],[y % 10]"

/turf/open/misc/moonstation_sand/break_tile()
	. = ..()
	icon_state = "damaged"

/turf/open/misc/moonstation_sand/broken_states()
	return list("damaged")

//Rock
/turf/open/misc/moonstation_rock
	name = "lunar rock"
	gender = NEUTER
	desc = "You've hit rock bottom, and now you're here."
	initial_gas_mix = MOONSTATION_ATMOS
	icon = 'modular_zubbers/icons/turf/lunar_rock.dmi'
	icon_state = "0,0"
	planetary_atmos = TRUE

/turf/open/misc/moonstation_rock/break_tile()
	. = ..()
	icon_state = "damaged"

/turf/open/misc/moonstation_rock/broken_states()
	return list("damaged")

/turf/open/misc/moonstation_rock/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/diggable, /obj/item/stack/sheet/mineral/stone, 2, worm_chance = 1)
	icon_state = "[x % 10],[y % 10]"

//Misc
/turf/open/floor/plating/rust/moonstation
	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/catwalk_floor/rust
	baseturfs = /turf/open/floor/plating/rust

/turf/open/floor/catwalk_floor/rust/moonstation
	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/iron/solarpanel/moonstation
	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

