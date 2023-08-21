/obj/item/clothing/under/rank/security/officer/skirt/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "secskirt"
	current_skin = "secskirt" //prevents reskinning

/obj/item/clothing/under/rank/security/warden/skirt/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "rwarden_skirt"
	current_skin = "rwarden_skirt"

/obj/machinery/vending/wardrobe/sec_wardrobe
	name = "\improper Nanotrasen Security Outfitting Station"
	desc = "A vending machine stocked with NanoTrasen's \"SecDrobe Advanced\" security package, including standardized uniforms and general equipment."
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "secdrobe"
	light_mask = "sec-light-mask"
	product_ads = "Beat perps in style!;The stains wash right out!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	vend_reply = "Good luck, Officer!"
	products = list(

		//Uniforms
		/obj/item/clothing/under/rank/security/officer/redsec = 8,
		/obj/item/clothing/under/rank/security/officer/skirt/redsec = 8,
		/obj/item/clothing/under/rank/security/officer/grey = 4,
		/obj/item/clothing/under/rank/security/skyrat/utility/redsec = 4,

		//Backpacks
		/obj/item/storage/backpack/security/redsec = 4,
		/obj/item/storage/backpack/satchel/sec/redsec = 4,
		/obj/item/storage/backpack/duffelbag/sec/redsec = 4,

		//Ties
		/obj/item/clothing/neck/tie/red = 4,
		/obj/item/clothing/neck/tie/black = 4,

		//Shoes
		/obj/item/clothing/shoes/jackboots/sec/redsec = 8,
		/obj/item/clothing/shoes/wraps/red = 4,

		//Hats
		/obj/item/clothing/head/soft/sec = 8,
		/obj/item/clothing/head/beret/sec = 3,

		//Suit
		/obj/item/clothing/suit/hooded/wintercoat/security/redsec = 4,
		/obj/item/clothing/suit/toggle/jacket/sec/old = 4,

		//Gloves
		/obj/item/clothing/gloves/color/black = 8

	)

	premium = list(

		/obj/item/storage/belt/security/webbing = 2,

		/obj/item/clothing/under/rank/security/officer/formal = 4,
		/obj/item/clothing/suit/jacket/officer/tan = 4,
		/obj/item/clothing/head/beret/sec/navyofficer = 4,

		/obj/item/clothing/accessory/badge/old = 4,

		/obj/item/clothing/gloves/tackler = 2,

		/obj/item/clothing/mask/gas/sechailer/swat = 2,

		/obj/item/clothing/neck/security_cape = 4,
		/obj/item/clothing/neck/security_cape/armplate = 4


	)

	contraband = list(
		/obj/item/clothing/shoes/cowboy/black = 4,
		/obj/item/clothing/head/helmet/toggleable/justice/escape = 2,

		/obj/item/clothing/shoes/jackboots/black = 4,
		/obj/item/clothing/mask/bandana/red = 6
	)


	refill_canister = /obj/item/vending_refill/wardrobe/sec_wardrobe
	payment_department = ACCOUNT_SEC
	light_color = COLOR_RED

/obj/machinery/vending/wardrobe/sec_wardrobe/red
	name = "\improper Ancient SecDrobe"
	desc = "A vending machine for security and security-related clothing!"


/obj/machinery/vending/security
	name = "\improper Armadyne Peacekeeper Equipment Vendor"
	desc = "An Armadyne peacekeeper equipment vendor."
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon = 'modular_skyrat/modules/sec_haul/icons/vending/vending.dmi'
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/cable/zipties = 12,
		/obj/item/grenade/flashbang = 6,
		/obj/item/assembly/flash/handheld = 8,
		/obj/item/food/donut/plain = 12,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 6,
		/obj/item/restraints/legcuffs/bola/energy = 10,
	)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/storage/fancy/donut_box = 2,
		/obj/item/clothing/mask/whistle = 2
	)
	premium = list(
		/obj/item/storage/belt/security/webbing = 5,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 3,
		/obj/item/clothing/suit/armor/vest/blueshirt = 3,
		/obj/item/clothing/gloves/tackler/security = 5,
		/obj/item/grenade/stingbang = 5,
		/obj/item/watertank/pepperspray = 2
	)
