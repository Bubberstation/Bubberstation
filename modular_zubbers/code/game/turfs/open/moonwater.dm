/turf/open/water/moonstation

	name = "lunar water"
	gender = PLURAL
	desc = "Semi-shallow water containing a variety of natural and invasive fish species."

	icon = 'icons/turf/floors/moonwater.dmi'
	base_icon_state = "moonwater"
	icon_state = "moonwater-255"

	baseturfs = /turf/open/water/moonstation
	turf_flags = NO_RUST | TURF_BLOCKS_POPULATE_TERRAIN_FLORAFEATURES | NO_LAVA_GEN

	tiled_dirt = FALSE

	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

	immerse_overlay_color = "#366F7D"
	fishing_datum = /datum/fish_source/lunar

	//Copied from lava because why not.
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_MOONWATER
	canSmoothWith = SMOOTH_GROUP_MOONWATER

/turf/open/water/moonstation/surface

	name = "lunar surface water"

	icon = 'icons/turf/floors/moonwater_surface.dmi'
	base_icon_state = "moonwater_surface"
	icon_state = "moonwater_surface-255"

	fishing_datum = /datum/fish_source/lunar/surface

#define MOON_FISH_MYTHICAL 1
#define MOON_FISH_RARE 2
#define MOON_FISH_UNCOMMON 4
#define MOON_FISH_COMMON 8

/datum/fish_source/lunar
	catalog_description = "Lunar Waters"
	radial_state = "fryer"
	overlay_state = "portal_ocean"
	fish_table = list(
		FISHING_DUD = 20,
		/obj/item/fish/armorfish = MOON_FISH_COMMON,
		/obj/item/fish/boned = MOON_FISH_RARE,
		/obj/item/fish/dolphish = MOON_FISH_MYTHICAL,
		/obj/item/fish/gullion = MOON_FISH_MYTHICAL,
		/obj/item/fish/mastodon = MOON_FISH_RARE,
		/obj/item/fish/monkfish = MOON_FISH_COMMON,
		/obj/item/fish/plaice = MOON_FISH_COMMON,
		/obj/item/fish/sacabambaspis = MOON_FISH_RARE,
		/obj/item/fish/moonfish/dwarf = MOON_FISH_RARE,
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 30
	fish_source_flags = FISH_SOURCE_FLAG_EXPLOSIVE_MALUS
	associated_safe_turfs = list(/turf/open/water/moonstation)


/datum/fish_source/lunar/surface
	catalog_description = "Lunar Waters"
	radial_state = "fryer"
	overlay_state = "portal_ocean"
	fish_table = list(
		FISHING_DUD = 20,
		/obj/item/fish/bumpy = MOON_FISH_COMMON,
		/obj/item/fish/monkfish = MOON_FISH_COMMON,
		/obj/item/fish/plaice = MOON_FISH_COMMON,
		/obj/item/fish/sand_crab = MOON_FISH_UNCOMMON,
		/obj/item/fish/sand_surfer = MOON_FISH_COMMON,
		/obj/item/fish/stingray = MOON_FISH_RARE,
		/obj/item/fish/tadpole = MOON_FISH_COMMON,
		/obj/item/stack/sheet/bone = MOON_FISH_COMMON,
		/obj/item/food/grown/material_sand = MOON_FISH_RARE
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 20
	fish_source_flags = FISH_SOURCE_FLAG_EXPLOSIVE_MALUS
	associated_safe_turfs = list(/turf/open/water/moonstation/surface)



#undef MOON_FISH_MYTHICAL
#undef MOON_FISH_RARE
#undef MOON_FISH_UNCOMMON
#undef MOON_FISH_COMMON
