// not in a folder on it's own because rn we don't have enough
// if we start having more of those than just the calorite ones, we should just put it into a folder
// and name the files appropiately

/obj/item/stack/tile/mineral/calorite  //GS13
	name = "Calorite tile"
	singular_name = "Calorite floor tile"
	desc = "A tile made out of calorite. Bwoomph."
	icon = 'modular_gs/icons/obj/tiles.dmi'
	inhand_icon_state = null
	lefthand_file = null
	righthand_file = null
	icon_state = "tile_calorite"
	turf_type = /turf/open/floor/mineral/calorite
	mineralType = "calorite"
	mats_per_unit = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/calorite

/obj/item/stack/tile/mineral/calorite/hide  //GS13 - disguised variant
	name = "Floor tile"
	singular_name = "calorite floor tile"
	desc = "A tile totally made out of steel."
	icon_state = "tile"
	turf_type = /turf/open/floor/mineral/calorite/hide

/obj/item/stack/tile/mineral/calorite/strong  //GS13 - strong variant
	name = "Infused calorite tile"
	singular_name = "Infused calorite floor tile"
	desc = "A tile made out of stronger variant of calorite. Bwuurp."
	icon_state = "tile_calorite_strong"
	turf_type = /turf/open/floor/mineral/calorite/strong

/obj/item/stack/tile/mineral/calorite/dance  //GS13 - glamourous variant!
	name = "Calorite dance floor"
	singular_name = "Calorite dance floor tile"
	desc = "A dance floor made out of calorite, for a party both you and your waistline will never forget!."
	icon_state = "tile_calorite_dance"
	turf_type = /turf/open/floor/mineral/calorite/dance
