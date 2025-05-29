/obj/machinery/vending/mealdor
	name = "Meal Vendor"
	desc = "The vending machine used by starving people. Looks like they've changed the shell, it looks cuter."
	icon = 'GainStation13/icons/obj/vending.dmi'
	icon_state = "mealdor"
	product_slogans = "Are you hungry? Eat some of my food!;Be sure to eat one of our tasty treats!;Was that your stomach? Go ahead, get some food!"
	vend_reply = "Enjoy your meal."
	free = TRUE
	products = list(

	            /obj/item/reagent_containers/food/snacks/pizza/margherita = 15,
	            /obj/item/reagent_containers/food/snacks/butterdog = 10,
	            /obj/item/reagent_containers/food/snacks/burger/plain = 10,
				/obj/item/reagent_containers/food/snacks/fries = 5,
				/obj/item/reagent_containers/food/snacks/donut = 10,
				/obj/item/reagent_containers/food/snacks/burrito = 8,
	            /obj/item/reagent_containers/food/snacks/pie/plump_pie = 4,
				/obj/item/reagent_containers/food/snacks/store/cake/pound_cake = 20,
				/obj/item/reagent_containers/food/snacks/store/cake/cheese = 10,
				/obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice = 2,
				/obj/item/reagent_containers/food/snacks/cakeslice/bsvc = 3,
				/obj/item/reagent_containers/food/snacks/cakeslice/bscc = 3,
	            /obj/item/reagent_containers/food/drinks/bottle/orangejuice = 10,
	            /obj/item/reagent_containers/food/drinks/bottle/pineapplejuice = 10,
	            /obj/item/reagent_containers/food/drinks/bottle/strawberryjuice = 10,
	            /obj/item/reagent_containers/food/snacks/dough = 10
				)
	contraband = list(
				/obj/item/clothing/head/chefhat = 5,
				/obj/item/reagent_containers/food/snacks/cookie = 10,
				/obj/item/reagent_containers/food/snacks/salad/fruit = 15,
				/obj/item/reagent_containers/food/snacks/blueberry_gum = 5
				)
	premium = list(
				/obj/item/reagent_containers/food/drinks/soda_cans/air = 3,
				/obj/item/reagent_containers/food/snacks/donut/chaos = 3,
				/obj/item/clothing/mask/cowmask/gag = 2,
				/obj/item/clothing/mask/pig/gag = 2
				)

	refill_canister = /obj/item/vending_refill/mealdor
