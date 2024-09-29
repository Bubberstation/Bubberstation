/obj/machinery/vending/halloween_chocolate
	name = "\improper Robust Chocolate"
	desc = "A chocolate vendor provided by Robust Industries, LLC. Warranty Void if contents are consumed."
	icon = 'modular_zubbers/icons/obj/machines/halloween_chocolate_vendor.dmi'
	icon_state = "halloween"
	panel_type = "panel"
	product_slogans = "Robust Chocolate: More robust than a toolbox to the head!"
	product_ads = "Tasty!;Hope you're hungry!;Over 4 chocolate bars sold!;Hungry? Why not chocolate?;Please, have a snack!;Eat up!;The best chocolate in space."
	products = list(
		/obj/item/food/candy/coconut_joy = 8,
		/obj/item/food/candy/laughter_bar = 8,
		/obj/item/food/candy/kit_catgirl_metaclique_bar = 8,
		/obj/item/food/candy/twink_bar = 8,
		/obj/item/food/candy/elon_musk_bar = 8,
		/obj/item/food/candy/malf_way = 8
	)
	contraband = list(
		/obj/item/food/candy/hurr_bar = 2,
		/obj/item/food/candy/laughter_bar/slaughter = 2
	)
	premium = list(
		/obj/item/food/candy/hundred_credit_bar = 2,
		/obj/item/food/candy/triggerfinger = 2
	)
	refill_canister = /obj/item/vending_refill/halloween_chocolate
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV
	light_mask = "halloween-light-mask"
	light_color = COLOR_LIGHT_ORANGE

/obj/item/vending_refill/halloween_chocolate
	machine_name = "Robust Chocolate"
	icon_state = "refill_games"

/datum/supply_pack/vending/halloween_chocolate
	name = "Robust Chocolate Supply Crate"
	desc = "Got whacked by a toolbox, but you still have those pesky teeth? \
		Get rid of those pearly whites with this candy machine refill, today!"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/halloween_chocolate)
	crate_name = "robust chocolate supply crate"
