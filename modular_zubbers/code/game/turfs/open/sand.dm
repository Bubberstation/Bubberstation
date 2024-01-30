#define MOONSTATION_ATMOS GAS_O2 + "=16;" + GAS_N2 + "=74;" + GAS_WATER_VAPOR + "=4;TEMP=333.15"

/turf/open/misc/moonstation_sand
	name = "lunar sand"
	gender = PLURAL //fucking LIBERALS gendering my SAND oh my GOD *goes on an unhinged rant on reddit*
	desc = "Not to be confused with the legally distinct children's toy, this lunar sand is coarse and rough and gets everywhere."
	initial_gas_mix = MOONSTATION_ATMOS
	icon = 'modular_zubbers/icons/turf/lunarsand.dmi'
	icon_state = "0,0"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/misc/moonstation_sand/broken_states()
	return list("damaged")

/turf/open/misc/moonstation_sand/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/diggable, /obj/item/stack/ore/glass, 2, worm_chance = 10)
	icon_state = "[x % 10],[y % 10]"


/turf/open/floor/plating/rust/moonstation
	initial_gas_mix = MOONSTATION_ATMOS

/turf/open/floor/catwalk_floor/rust
	baseturfs = /turf/open/floor/plating/rust

/turf/open/floor/catwalk_floor/rust/moonstation
	initial_gas_mix = MOONSTATION_ATMOS

/turf/open/floor/iron/solarpanel/moonstation
	initial_gas_mix = MOONSTATION_ATMOS