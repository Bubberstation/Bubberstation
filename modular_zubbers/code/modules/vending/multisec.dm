/obj/machinery/vending/wardrobe/sec_wardrobe
	name = "\improper MultiSec Outfitting Station"
	desc = "A vending machine stocked with a multitude of security outfits, including standardized uniforms in multiple colors and general equipment. Now with more Multi!"
	icon = 'modular_zubbers/icons/obj/machines/multisec.dmi'
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
					/obj/item/clothing/under/rank/security/peacekeeper/skirt = 10,
					/obj/item/clothing/under/rank/security/peacekeeper/shortskirt = 10,
					/obj/item/clothing/under/rank/security/peacekeeper/miniskirt = 10,
					/obj/item/clothing/under/rank/security/officer/blueshirt = 10,
					/obj/item/clothing/under/rank/security/peacekeeper/trousers = 5,
					/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts = 5,
					/obj/item/clothing/under/rank/security/skyrat/utility = 6,
					/obj/item/clothing/shoes/jackboots/sec = 10,
					/obj/item/clothing/head/security_garrison = 10,
					/obj/item/clothing/head/security_cap = 10,
					/obj/item/clothing/head/beret/sec/peacekeeper = 6,
					/obj/item/clothing/head/beret/sec/peacekeeper/white = 6,
					/obj/item/clothing/head/helmet/sec/terra = 6,
					/obj/item/clothing/head/hats/warden/police/patrol = 6,
					/obj/item/clothing/head/costume/ushanka/sec = 10,
					/obj/item/clothing/gloves/color/black/security = 10,
					/obj/item/clothing/head/helmet/sec/futuristic = 6,
					/obj/item/clothing/suit/armor/vest/collared_vest = 6, //added by Bangle
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
					/obj/item/clothing/under/rank/security/peacekeeper/armadyne = 6,
					/obj/item/clothing/under/rank/security/peacekeeper/armadyne/tactical = 6,
					/obj/item/clothing/shoes/jackboots = 6,
					/obj/item/clothing/shoes/jackboots/peacekeeper/armadyne = 6,
					/obj/item/clothing/shoes/jackboots/gogo_boots = 6,
					/obj/item/clothing/head/helmet/sec/redsec = 6,
					/obj/item/clothing/head/beret/sec = 6,
					/obj/item/clothing/head/beret/sec/peacekeeper/armadyne = 6,
					/obj/item/clothing/head/soft/sec = 6,
					/obj/item/clothing/head/beaniesec = 6,
					/obj/item/clothing/head/playbunnyears/security = 6,
					/obj/item/clothing/under/rank/security/security_bunnysuit = 6,
					/obj/item/clothing/suit/armor/security_tailcoat = 6,
					/obj/item/clothing/neck/tie/bunnytie/security = 6,
					/obj/item/clothing/head/playbunnyears/security/assistant = 6,
					/obj/item/clothing/under/rank/security/security_assistant_bunnysuit = 6,
					/obj/item/clothing/suit/armor/security_tailcoat/assistant = 6,
					/obj/item/clothing/neck/tie/bunnytie/security_assistant = 6,
					/obj/item/clothing/mask/bandana/red = 6,
					/obj/item/clothing/neck/pauldron = 6,
					/obj/item/clothing/neck/pauldron/commander = 6,
					/obj/item/clothing/neck/pauldron/captain = 6,
					/obj/item/clothing/gloves/color/black = 6,
					/obj/item/clothing/gloves/combat/peacekeeper/armadyne = 6,
					/obj/item/clothing/under/rank/security/officer/skirt = 6,
					/obj/item/clothing/under/rank/security/skyrat/utility/redsec = 6,
					/obj/item/clothing/suit/toggle/jacket/sec/old = 6,
					/obj/item/clothing/suit/armor/vest/secjacket = 6,
					/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne = 6,
					/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor = 6,
					/obj/item/clothing/suit/armor/vest/caligram_parka_vest_tan = 6,
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
					/obj/item/clothing/head/beret/sec/peacekeeper/security_medic = 3,
					/obj/item/clothing/head/playbunnyears/brig_phys = 3,
					/obj/item/clothing/under/rank/security/brig_phys_bunnysuit = 3,
					/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/sec = 3,
					/obj/item/clothing/neck/tie/bunnytie/brig_phys = 3,
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
					/obj/item/clothing/head/helmet/metrocophelmet = 6,
					/obj/item/clothing/suit/armor/metrocop = 6,
					/obj/item/clothing/suit/armor/metrocopriot = 6,
					/obj/item/clothing/accessory/badge/holo = 10, //I know there's a box of them but, why not have more, eh?
					/obj/item/clothing/accessory/badge/holo/cord = 10,
					/obj/item/clothing/head/helmet/blueshirt = 3,
					/obj/item/clothing/suit/armor/vest/blueshirt = 3,
					/obj/item/riding_saddle/leather/peacekeeper = 3,
	)

//CONTRABAND: Basically for less serious/hard to cat stuff like the Cowboy and Bluecoat stuff. And for stuff that shouldn't be easy to get like HUD varients.


	contraband = list(
					/obj/item/clothing/under/colonial/nri_police = 3,
					/obj/item/clothing/suit/british_officer = 3,
					/obj/item/clothing/head/cowboy/skyrat/cattleman/sec = 3,
					/obj/item/clothing/head/cowboy/skyrat/cattleman/wide/sec = 3,
					/obj/item/clothing/head/fedora/det_hat/cybergoggles = 3,
					/obj/item/clothing/glasses/hud/eyepatch/sec = 3, //No flash protection on the eyepatches, so they're worse than the sunnies.
					/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold = 3, //Ditto
					/obj/item/clothing/glasses/hud/ar/aviator/security = 3, //Printable, but you have to choose between HUD and flash protection.
					/obj/item/clothing/glasses/hud/ar/projector/security = 3,
					/obj/item/clothing/mask/gas/half_mask = 3,
					/obj/item/clothing/under/rank/prisoner/classic = 6, //To be given to Prisoners.
					/obj/item/clothing/head/playbunnyears/prisoner = 6,
					/obj/item/clothing/under/rank/security/prisoner_bunnysuit = 6,
					/obj/item/clothing/neck/tie/bunnytie/prisoner = 6,
					/obj/item/clothing/head/hats/caphat/parade/fedcap/sec = 3,
					/obj/item/clothing/suit/fedcoat/modern/sec = 3,
					/obj/item/clothing/mask/gas/soviet = 3,
					/obj/item/clothing/mask/gas/german = 3, //As far as I can tell, this is nowhere else in the game.
					/obj/item/clothing/under/rank/security/corrections_officer = 2, //If, or more likely when the Brig Officers abandon them, you can now get 'em here! Yay! Wahoo!
					/obj/item/clothing/under/rank/security/corrections_officer/skirt = 2,
					/obj/item/clothing/under/rank/security/corrections_officer/sweater = 2,
					/obj/item/clothing/under/rank/security/corrections_officer/sweater/skirt = 2,
					/obj/item/clothing/suit/toggle/jacket/corrections_officer = 2,
					/obj/item/clothing/head/soft/veteran = 1,
					/obj/item/clothing/head/helmet/toggleable/justice = 1, //More than one of these in the Vendor and they'll get annoying fast. Hence why Justice2 isn't here.
	)

	payment_department = ACCOUNT_SEC


/obj/item/vending_refill/wardrobe/sec_wardrobe
	machine_name = "MultiSec Outfitting Station"
