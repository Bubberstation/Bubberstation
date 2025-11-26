/datum/supply_pack/misc/americacrate
	name = "Freedom Crate"
	desc = "FREEDOM. FREEDOM. FREEDOM. Freedom aint not free. Buy our flags, pray to the flag, worship the flag. Dress up as the founder and kneel at the alter of the flag that created everything. Guns sold seperately."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/sign/flag/usa,
		/obj/item/sign/flag/usa,
		/obj/item/food/burger/superbite,
		/obj/item/bedsheet/patriot,
		/obj/item/bedsheet/patriot/double,
		/obj/item/food/burger/cheese,
		/obj/item/food/burger/superbite,
		/obj/item/clothing/under/costume/griffin,
		/obj/item/clothing/head/costume/griffin,
	)
	crate_name = "patriotic crate"
	contraband = TRUE

/datum/supply_pack/misc/lizardcrate
	name = "Lizard Crate"
	desc = "Limited edition Lizard Crate! Contains your FAVOURITE lizard related items, including the coveted 'weh-nade'"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/grenade/chem_grenade/wehnade = 2,
		/obj/item/toy/plush/lizard_plushie = 2,
		/obj/item/toy/plush/lizard_plushie/green = 2,
		/obj/item/toy/plush/lizard_plushie/space = 2,
		/obj/effect/spawner/random/food_or_drink/snack/lizard = 4,
		/obj/structure/sign/poster/contraband/lizard,
		/obj/structure/sign/poster/contraband/imperial_propaganda,
		/mob/living/basic/lizard = 4,
	)
	crate_type = /obj/structure/closet/crate/wooden
	crate_name = "Lizard Crate"
	contraband = TRUE
