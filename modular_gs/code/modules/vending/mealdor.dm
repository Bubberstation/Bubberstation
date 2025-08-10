/obj/machinery/vending/mealdor
	name = "Meal Vendor"
	desc = "The vending machine used by starving people. Looks like they've changed the shell, it looks cuter."
	icon = 'modular_gs/icons/obj/vending.dmi'
	icon_state = "mealdor"
	product_slogans = "Are you hungry? Eat some of my food!;Be sure to eat one of our tasty treats!;Was that your stomach? Go ahead, get some food!"
	vend_reply = "Enjoy your meal."
	free = TRUE
	products = list(

	            /obj/item/food/pizza/margherita = 15,
	            /obj/item/food/butterdog = 10,
	            /obj/item/food/burger/plain = 10,
				/obj/item/food/fries = 5,
				/obj/item/food/donut = 10,
				/obj/item/food/burrito = 8,
	            /obj/item/food/pie/plump_pie = 4,
				/obj/item/food/cake/pound_cake = 20,
				/obj/item/food/cake/cheese = 10,
				/obj/item/food/cake/pumpkinspice = 2,
	            /obj/item/reagent_containers/cup/glass/bottle/orangejuice = 10,
	            /obj/item/reagent_containers/cup/glass/bottle/pineapplejuice = 10,
	            /obj/item/reagent_containers/cup/glass/bottle/strawberryjuice = 10,
	            /obj/item/food/dough = 10
				)
	contraband = list(
				/obj/item/clothing/head/utility/chefhat = 5,
				/obj/item/food/cookie = 10,
				/obj/item/food/salad/fruit = 15,
				///obj/item/food/blueberry_gum = 5
				)
	premium = list(
				///obj/item/reagent_containers/cup/soda_cans/air = 3,
				/obj/item/food/donut/chaos = 3,
				///obj/item/clothing/mask/cowmask/gag = 2,
				///obj/item/clothing/mask/pig/gag = 2
				)

	refill_canister = /obj/item/vending_refill/mealdor
