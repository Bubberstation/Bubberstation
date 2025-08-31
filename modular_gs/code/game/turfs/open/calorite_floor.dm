/turf/open/floor/mineral/calorite
	name = "Calorite floor"
	icon = 'modular_gs/icons/turf/floors.dmi'
	damaged_dmi = 'modular_gs/icons/turf/floors.dmi'
	icon_state = "calorite"
	floor_tile = /obj/item/stack/tile/mineral/calorite
	icons = "calorite"
	var/last_event = 0
	var/active = null
	///How much fatness is added to the user upon crossing?
	var/fat_to_add = 25

/turf/open/floor/mineral/calorite/Entered(mob/living/carbon/M)
	if(!istype(M, /mob/living/carbon))
		return FALSE
	else
		M.adjust_fatness(fat_to_add, FATTENING_TYPE_ITEM)

// calorite floor, disguised version - GS13

/turf/open/floor/mineral/calorite/hide
	name = "Steel floor"
	icon_state = "calorite_hide"
	floor_tile = /obj/item/stack/tile/mineral/calorite/hide
	icons = "calorite_hide"
	damaged_dmi = null

// calorite floor, powerful version - GS13

/turf/open/floor/mineral/calorite/strong
	name = "Infused calorite floor"
	icon_state = "calorite_strong"
	floor_tile = /obj/item/stack/tile/mineral/calorite/strong
	damaged_dmi = null
	icons = "calorite_strong"
	fat_to_add = 100

// calorite dance floor, groovy! - GS13

/turf/open/floor/mineral/calorite/dance
	name = "Calorite dance floor"
	icon_state = "calorite_dance"
	floor_tile = /obj/item/stack/tile/mineral/calorite/dance
	icons = "calorite_dance"
	damaged_dmi = null
