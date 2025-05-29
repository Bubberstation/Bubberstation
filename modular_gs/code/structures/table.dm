/obj/structure/table/plaswood
	name = "plaswood table"
	desc = "An strong and grey wooden table."
	icon = 'GainStation13/icons/obj/smooth_structures/plaswoodpoker_table.dmi'
	icon_state = "plaswood_table"
	resistance_flags = FLAMMABLE
	max_integrity = 200
	integrity_failure = 50
	armor = list("melee" = 10, "bullet" = 30, "laser" = 30, "energy" = 100, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70)
	canSmoothWith = list(/obj/structure/table/plaswood,
		/obj/structure/table/plaswood/plaswoodpoker)

/obj/structure/table/plaswood/plaswoodpoker
	name = "gambling table"
	desc = "A seedy table for seedy dealings in seedy places."
	icon = 'GainStation13/icons/obj/smooth_structures/plaswoodpoker_table.dmi'
	icon_state = "plaswoodpoker_table"
	buildstack = /obj/item/stack/tile/carpet

/obj/structure/table/gmushroom
	name = "Mushroom table"
	desc = "A pinkish table. And is fireproof!"
	icon = 'GainStation13/icons/obj/smooth_structures/gmushroom_table.dmi'
	icon_state = "gmushroom_table"
	resistance_flags = FIRE_PROOF
	max_integrity = 70
	canSmoothWith = list(/obj/structure/table/gmushroom,
		/obj/structure/table/gmushroom/gmushroompoker)

/obj/structure/table/gmushroom/gmushroompoker
	name = "gambling table"
	desc = "A seedy table for seedy dealings in seedy places."
	icon = 'GainStation13/icons/obj/smooth_structures/gmushroompoker_table.dmi'
	icon_state = "gmushroompoker_table"
	buildstack = /obj/item/stack/tile/carpet
