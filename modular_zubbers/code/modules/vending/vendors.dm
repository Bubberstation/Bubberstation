/obj/machinery/vending/imported/barkbox
	name = "Bark Box"
	desc = "For all your pet needs!"
	icon = 'modular_zubbers/icons/obj/vending.dmi'
	icon_state = "barkbox"
	product_slogans = "Whuff!;Bark!;Give me a treat!"
	product_categories = list(
		list(
			"name" = "Bark-items",
			"products" = list(
				/obj/item/storage/fancy/treat_box = 8,
				/obj/item/clothing/neck/petcollar = 5,
				/obj/item/clothing/neck/petcollar/ribbon = 5,
				/obj/item/clothing/neck/petcollar/leather = 5,
				/obj/item/toy/tennis = 4,
				/obj/item/dog_bone = 4,
				/obj/item/toy/frisbee = 4,
				),
			),
	)
	contraband = list()
	premium = list()
	refill_canister = /obj/item/vending_refill/barkbox
	default_price = PAYCHECK_CREW * 0.5
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES

/obj/item/vending_refill/barkbox
	machine_name 	= "Bark Box"
	icon_state 		= "refill_barkbox"

/obj/effect/spawner/random/vending/snackvend/New()
	.=..()
	loot += list(/obj/machinery/vending/imported/barkbox)
