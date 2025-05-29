//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.

/datum/supply_pack/organic/large_donut_boxes
	name = "Large Donut Boxes"
	desc = "Tired of eating pizza all day? Security ate all the donuts and keeps asking for more? Fear not! This crate contains 2 large boxes of donuts, 16 donuts each! That'll be sure to stave off those hungry seccies... for a while."
	cost = 5500
	contains = list(/obj/item/storage/fancy/large_donut_box,
					/obj/item/storage/fancy/large_donut_box)

/datum/supply_pack/organic/strangeseeds
	name = "Strange Seeds Crate"
	desc = "After our chemical waste mysteriously disappeared we've discovered many strange and interesting species of plants, and they're yours for the taking! Contains 8 packs of strange seeds."
	cost = 4500
	contains = list(/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random)
	crate_name = "strange seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics