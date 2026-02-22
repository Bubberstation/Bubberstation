/obj/machinery/vending/wardrobe/sec_wardrobe
	products = list() // Overriding this to the default to prevent any issues when building the product menu
	product_categories = list(
		list(
			"name" = "Red",
			"icon" = "shield",
			"products" = list(
					/obj/item/clothing/under/rank/security/officer/viro = 6,
					/obj/item/clothing/under/rank/security/officer/viro/skirt = 6,
					/obj/item/clothing/under/rank/security/officer/viro/jumpsuit = 6,
					/obj/item/clothing/under/rank/security/officer/formal = 6,
					/obj/item/clothing/under/rank/security/officer/formal/skirt = 6,
					/obj/item/clothing/under/rank/security/officer/viro/lowcut = 6,
					/obj/item/clothing/under/rank/security/officer/viro/bodysuit = 6,
					/obj/item/clothing/suit/armor/vest/alt/sec/viro = 6,
					/obj/item/clothing/suit/armor/vest/alt/sec/viro/heavyvest = 6,
					/obj/item/clothing/suit/armor/vest/alt/sec/viro/leatherjacket = 6,
					/obj/item/clothing/suit/armor/vest/alt/sec/viro/softshell = 6,
					/obj/item/clothing/head/helmet/sec = 6,
					/obj/item/clothing/head/beret/sec/viro = 6,
					/obj/item/clothing/head/soft/sec = 6,
					/obj/item/clothing/head/security_beanie = 6,
					/obj/item/clothing/mask/bandana/sec = 6,
					/obj/item/clothing/gloves/color/black = 6,
					/obj/item/clothing/gloves/color/black/security = 6,
					/obj/item/storage/backpack/security/ = 6,
					/obj/item/storage/backpack/satchel/sec = 6,
					/obj/item/storage/backpack/duffelbag/sec = 6,
					/obj/item/storage/backpack/messenger/sec = 6,
					/obj/item/clothing/shoes/jackboots = 6,
					/obj/item/clothing/shoes/jackboots/sec = 6,

				),
			),
		list(
			"name" = "Medic",
			"icon" = "notes-medical",
			"products" = list(
					/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic = 3,
					/obj/item/clothing/suit/hazardvest/security_medic = 3,
					/obj/item/clothing/head/helmet/sec/security_medic = 3,
					/obj/item/clothing/head/beret/sec/security_medic = 3,
					/obj/item/clothing/head/playbunnyears/brig_phys = 3,
					/obj/item/clothing/under/rank/security/brig_phys_bunnysuit = 3,
					/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/doctor_tailcoat = 3,
					/obj/item/clothing/neck/tie/bunnytie/brig_phys = 3,
					/obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec = 3,
					/obj/item/clothing/under/rank/security/security_medic/alternate = 3,
					/obj/item/clothing/under/rank/security/security_medic = 3,
					/obj/item/clothing/under/rank/security/security_medic/skirt = 3,
				)
			),
		list(
			"name" = "Corrections",
			"icon" = "handcuffs",
			"products" = list(
				/obj/item/clothing/under/rank/security/corrections_officer = 2, //If, or more likely when the Brig Officers abandon them, you can now get 'em here! Yay! Wahoo!
				/obj/item/clothing/under/rank/security/corrections_officer/skirt = 2,
				/obj/item/clothing/under/rank/security/corrections_officer/sweater = 2,
				/obj/item/clothing/under/rank/security/corrections_officer/sweater/skirt = 2,
				/obj/item/clothing/suit/toggle/jacket/corrections_officer = 2,
				/obj/item/clothing/under/rank/prisoner/classic = 6, //To be given to Prisoners.
				/obj/item/clothing/head/playbunnyears/prisoner = 6,
				/obj/item/clothing/under/rank/security/prisoner_bunnysuit = 6,
				/obj/item/clothing/neck/tie/bunnytie/prisoner = 6,
			),
		),
	)
	premium = list(
					/obj/item/clothing/accessory/badge/holo = 10, //I know there's a box of them but, why not have more, eh?
					/obj/item/clothing/accessory/badge/holo/cord = 10,
					/obj/item/riding_saddle/leather/peacekeeper = 3,
	)

//CONTRABAND: Basically for less serious/hard to cat stuff like the Cowboy and Bluecoat stuff. And for stuff that shouldn't be easy to get like HUD varients.


	contraband = list(
					/obj/item/clothing/mask/gas/half_mask = 3,
					/obj/item/clothing/head/soft/veteran = 1,
					/obj/item/clothing/head/helmet/toggleable/justice = 1, //More than one of these in the Vendor and they'll get annoying fast. Hence why Justice2 isn't here.
	)

	payment_department = ACCOUNT_SEC


/obj/item/vending_refill/wardrobe/sec_wardrobe
	machine_name = "SecDrobe Outfitting Station"
