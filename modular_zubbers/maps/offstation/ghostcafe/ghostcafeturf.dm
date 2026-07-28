/turf/open/lava/fake
	name = "lava"
	desc = "Go on. Step in it. Maybe you'll be like some sort of Lava based Jesus."
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/lava/fake
	lava_damage = 0
	lava_firestacks = 0
	temperature_damage = 0
	slowdown = 0
	immunity_trait = TRAIT_GHOSTROLE
	immunity_resistance_flags = LAVA_PROOF
	fish_source_type = /datum/fish_source/lavaland/cafe

/turf/open/lava/fake/Initialize(mapload)
	// burn_stuff() only checks TRAIT_LAVA_STOPPED. Zeroing lava_damage/temperature_damage does not
	// spare objects, because do_burn() force-flags them FLAMMABLE and strips FIRE_PROOF regardless.
	// Added before the parent call, which runs Entered() on anything already mapped onto us.
	ADD_TRAIT(src, TRAIT_LAVA_STOPPED, INNATE_TRAIT)
	return ..()

/// The cafe's lava is decoration, so it fishes like lavaland minus everything that surfaces wanting to kill you.
/datum/fish_source/lavaland/cafe
	catalog_description = null //it's just the lavaland table with the teeth pulled, no need to list it twice
	fish_source_flags = FISH_SOURCE_FLAG_EXPLOSIVE_MALUS | FISH_SOURCE_FLAG_NO_BLUESPACE_ROD
	fish_table = list(
		FISHING_DUD = 5,
		/obj/item/stack/ore/slag = 15,
		/obj/item/fish/lavaloop = 15,
		/obj/item/stack/sheet/animalhide/goliath_hide = 15,
		/obj/item/stack/sheet/bone = 15,
		/obj/item/stack/sheet/sinew = 15,
		/obj/structure/closet/crate/necropolis/tendril = 1,
		/obj/item/skeleton_key = 1,
		/obj/item/stack/sheet/mineral/runite = 1,
		/obj/effect/mob_spawn/corpse/human/charredskeleton = 1,
	)

/turf/open/floor/plating/vox
	name = "nitrogen-filled plating"
	desc = "Vox box certified."
	initial_gas_mix = "n2=104;TEMP=293.15"

/turf/open/indestructible/bathroom
	icon = 'modular_skyrat/modules/ghostcafe/icons/floors.dmi';
	icon_state = "titanium_blue_old";
	name = "bathroom floor"
	footstep = FOOTSTEP_FLOOR
	tiled_turf = FALSE

/turf/open/indestructible/carpet
	desc = "It's really cozy! Great for soft paws!";
	icon = 'modular_skyrat/modules/ghostcafe/icons/carpet_royalblack.dmi';
	icon_state = "carpet";
	name = "soft carpet"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE

/turf/open/water/hot_spring/cafe
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
