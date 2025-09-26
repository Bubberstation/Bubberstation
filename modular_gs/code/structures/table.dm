/obj/structure/table/plaswood
	name = "plaswood table"
	desc = "An strong and grey wooden table."
	icon = 'modular_gs/icons/obj/smooth_structures/plaswoodpoker_table.dmi'
	icon_state = "plaswood_table"
	resistance_flags = FLAMMABLE
	max_integrity = 200
	integrity_failure = 50
	canSmoothWith = list(/obj/structure/table/plaswood,
		/obj/structure/table/plaswood/plaswoodpoker)

/obj/structure/table/plaswood/plaswoodpoker
	name = "gambling table"
	desc = "A seedy table for seedy dealings in seedy places."
	icon = 'modular_gs/icons/obj/smooth_structures/plaswoodpoker_table.dmi'
	icon_state = "plaswoodpoker_table"
	buildstack = /obj/item/stack/tile/carpet

/obj/structure/table/gmushroom
	name = "Mushroom table"
	desc = "A pinkish table. And is fireproof!"
	icon = 'modular_gs/icons/obj/smooth_structures/gmushroom_table.dmi'
	icon_state = "gmushroom_table"
	resistance_flags = FIRE_PROOF
	max_integrity = 70
	canSmoothWith = list(/obj/structure/table/gmushroom,
		/obj/structure/table/gmushroom/gmushroompoker)

/obj/structure/table/gmushroom/gmushroompoker
	name = "gambling table"
	desc = "A seedy table for seedy dealings in seedy places."
	icon = 'modular_gs/icons/obj/smooth_structures/gmushroompoker_table.dmi'
	icon_state = "gmushroompoker_table"
	buildstack = /obj/item/stack/tile/carpet
