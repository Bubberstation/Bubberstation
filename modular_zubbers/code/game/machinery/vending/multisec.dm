/obj/machinery/vending/wardrobe/sec_wardrobe
	name = "\improper MultiSec Outfitting Station"
	desc = "A vending machine stocked with a multitude of security outfits, including standardized uniforms in multiple colors and general equipment. Now with more Multi!"
	icon = 'modular_zubbers/code/game/machinery/vending/multisec.dmi'
	icon_state = "multisec"
	light_mask = null
	products = list() // Overriding this to the default to prevent any issues when building the product menu
	product_categories = list(
		list(
			"name" = "Blue",
			"icon" = "shield-halved",
			"products" = list(
					/obj/item/clothing/suit/hooded/wintercoat/security = 6,
					/obj/item/clothing/suit/toggle/jacket/sec = 6,
					/obj/item/clothing/suit/armor/vest/secjacket/blue = 6,
					/obj/item/clothing/suit/armor/vest/peacekeeper/brit = 6,
					/obj/item/clothing/neck/security_cape = 6,
					/obj/item/clothing/neck/security_cape/armplate = 6,
					/obj/item/storage/backpack/security = 6,
					/obj/item/storage/backpack/satchel/sec = 6,
					/obj/item/storage/backpack/duffelbag/sec = 6,
					/obj/item/storage/backpack/duffelbag/sec = 6,
					/obj/item/clothing/under/rank/security/officer = 10,
					/obj/item/clothing/under/rank/security/officer/skirt/blue = 10,
					/obj/item/clothing/under/rank/security/peacekeeper = 10,
					/obj/item/clothing/under/rank/security/skyrat/utility = 6,
					/obj/item/clothing/shoes/jackboots/sec = 10,
					/obj/item/clothing/head/security_garrison = 10,
					/obj/item/clothing/head/security_cap = 10,
					/obj/item/clothing/head/beret/sec/peacekeeper = 6,
					/obj/item/clothing/head/helmet/sec/sol = 6,
					/obj/item/clothing/head/hats/warden/police/patrol = 6,
					/obj/item/clothing/head/costume/ushanka/sec = 10,
					/obj/item/clothing/gloves/color/black/security = 10,
				),
			),
		list(
			"name" = "Red",
			"icon" = "shield",
			"products" = list(
					/obj/item/clothing/suit/hooded/wintercoat/security/redsec = 6,
					/obj/item/storage/backpack/security/redsec = 6,
					/obj/item/storage/backpack/satchel/sec/redsec = 6,
					/obj/item/storage/backpack/duffelbag/sec/redsec = 6,
					/obj/item/clothing/under/rank/security/officer/redsec = 6,
					/obj/item/clothing/shoes/jackboots = 6,
					/obj/item/clothing/head/beret/sec = 6,
					/obj/item/clothing/head/soft/sec = 6,
					/obj/item/clothing/head/beaniesec = 6,
					/obj/item/clothing/mask/bandana/red = 6,
					/obj/item/clothing/gloves/color/black = 6,
					/obj/item/clothing/under/rank/security/officer/skirt = 6,
					/obj/item/clothing/under/rank/security/skyrat/utility/redsec = 6,
					/obj/item/clothing/suit/toggle/jacket/sec/old = 6,
					/obj/item/clothing/suit/armor/vest/secjacket = 6,
				),
			),
		list(
			"name" = "Medic",
			"icon" = "notes-medical",
			"products" = list(
					/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic = 3,
					/obj/item/clothing/suit/hazardvest/security_medic = 3,
					/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue = 3,
					/obj/item/clothing/suit/hazardvest/security_medic/blue = 3,
					/obj/item/clothing/head/helmet/sec/peacekeeper/security_medic = 3,
					/obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec = 3,
					/obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate = 3,
					/obj/item/clothing/under/rank/security/peacekeeper/security_medic = 3,
					/obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt = 3,
				)
			)
	)
	premium = list(
					/obj/item/clothing/under/rank/security/officer/formal = 6,
					/obj/item/clothing/suit/jacket/officer/blue = 6,
					/obj/item/clothing/head/beret/sec/navyofficer = 6,
					/obj/item/clothing/under/rank/security/officer/formal = 6,
					/obj/item/clothing/suit/jacket/officer/tan = 6,
					/obj/item/clothing/head/beret/sec/navyofficer = 6,
					/obj/item/clothing/head/helmet/metrocophelmet = 6,
					/obj/item/clothing/suit/armor/metrocop = 6,
					/obj/item/clothing/suit/armor/metrocopriot = 6,
	)
	payment_department = ACCOUNT_SEC

/obj/item/vending_refill/wardrobe/sec_wardrobe
	machine_name = "MultiSec Outfitting Station"
