/obj/effect/spawner/random/lizard_crate
	name = "lizard loot spawner"
	desc = "What wondrous lizard related good could it contain?"
	icon_state = "plushie"
	spawn_loot_double = TRUE
	loot = list(
		//plushies
		/obj/item/toy/plush/lizard_plushie/space = 40,
		/obj/item/toy/plush/lizard_plushie/space/green = 50,
		/obj/item/toy/plush/lizard_plushie/greyscale = 40,
		/obj/item/toy/plush/lizard_plushie/green = 40,
		/obj/item/toy/plush/lizard_plushie = 40,

		//wehnade
		/obj/item/grenade/chem_grenade/wehnade = 10,

		//assorted lizard foods
		/obj/item/food/tiziran_sausage = 10,
		/obj/item/food/crispy_headcheese = 10,
		/obj/item/food/lizard_surf_n_turf = 5,
		/obj/item/food/pizza/flatbread/imperial = 10,

		//lil lizards
		/mob/living/basic/lizard = 40
	)
