/datum/voucher_set/mining/bunny
	name = "Bunny Conscription Kit"
	description = "Designed for Miners on the planet of Carota, this kit includes all you need to imitate them! Weapons sold seperately."
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	set_items = list(
		/obj/item/storage/backpack/duffelbag/mining_bunny/conscript,
		)

/obj/item/storage/backpack/duffelbag/mining_bunny/conscript/PopulateContents()
	..()
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/encryptionkey/headset_mining(src)
	new /obj/item/card/id/advanced/mining(src)
	new /obj/item/knife/shiv/carrot(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/storage/lunchbox/bunny/carrot(src)

/obj/item/storage/lunchbox/bunny/carrot
	name = "carrot lunchbox"
	desc = "Who needs Mesons?"

/obj/item/storage/lunchbox/bunny/carrot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/grown/carrot(src)

/datum/voucher_set/mining_suit
	blackbox_key = "suit_voucher_redeemed"

/datum/voucher_set/mining_suit/explorer
	name = "Explorer Suit"
	description = "An armoured suit for exploring harsh environments. It can be reinforced with goliath plates."
	icon = 'icons/obj/clothing/suits/utility.dmi'
	icon_state = "explorer"
	set_items = list(
		/obj/item/clothing/suit/hooded/explorer,
		/obj/item/clothing/mask/gas/explorer,
	)

/datum/voucher_set/mining_suit/seva
	name = "SEVA Suit"
	description = "A fire-proof suit for exploring hot environments. It can't be reinforced with goliath plates, but is ash storm proof."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	icon_state = "seva"
	set_items = list(
		/obj/item/clothing/suit/hooded/seva,
		/obj/item/clothing/mask/gas/seva,
	)

/datum/voucher_set/mining_suit/carota
	name = "Bunny Suit"
	description = "Designed for Miners on the planet of Carota, while you might get some odd looks from your co-workers, decency is a foreign word around here."
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	set_items = list(
		/obj/item/clothing/head/playbunnyears/miner,
		/obj/item/clothing/neck/tie/bunnytie/miner,
		/obj/item/clothing/suit/jacket/tailcoat/miner,
		/obj/item/clothing/under/rank/cargo/miner/bunnysuit,
		/obj/item/clothing/shoes/workboots/mining/heeled,
		/obj/item/clothing/mask/gas/explorer, //No bunny mask, this'll have to do.
	)

/datum/voucher_set/mining_suit/winter
	name = "Winter Suit"
	description = "Brr! Chilly! While this won't get you far on Lavaland, it's perfectly suited for colder locales! Includes free Hot Coco!"
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	icon_state = "coatminer"
	set_items = list(
		/obj/item/clothing/suit/hooded/wintercoat/miner,
		/obj/item/reagent_containers/cup/glass/mug/coco,
	)

/datum/voucher_set/mining_suit/bomber
	name = "Bomber Jacket"
	description = "Trade in a hood for what your great-grandparents called 'Aura'. Cigars and or mask sold seperately."
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "bombermining"
	set_items = list(
		/obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining,
	)

/datum/voucher_set/security

/datum/voucher_set/security/primary

/datum/voucher_set/security/utility

/datum/voucher_set/security/brig_physician

/datum/voucher_set/security/primary/disabler
	name = "Disabler"
	description = "The standard issue energy gun of Nanotrasen security forces. Comes with it's own holster."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "disabler"
	set_items = list(
		/obj/item/storage/belt/holster/energy/disabler,
		)

/datum/voucher_set/security/primary/advanced_taser
	name = "Hybrid Taser"
	description = "A dual-mode taser designed to fire both short-range high-power electrodes and long-range disabler beams."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "advtaser"
	set_items = list(
		/obj/item/gun/energy/e_gun/advtaser,
		)

/datum/voucher_set/security/primary/disabler_smg
	name = "Pepperball AGH"
	description = "A slower firing handgun that fires 'pepperballs', which easily drop targets to the floor."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/pepperball.dmi'
	icon_state = "peppergun"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/pepperball,
		/obj/item/ammo_box/magazine/pepperball
		)

/datum/voucher_set/security/primary/strobe_shield
	name = "Strobe Shield"
	description = "A shield with a built in, high intensity light capable of blinding and disorienting suspects. Takes regular handheld flashes as bulbs."
	icon = 'icons/obj/weapons/shields.dmi'
	icon_state = "flashshield"
	set_items = list(
		/obj/item/shield/riot/flash,
		)


/datum/voucher_set/security/utility/sec_projector
	name = "Security Holobarrier Projector"
	description = "A holographic projector that creates holographic security barriers along with holographic handcuffs."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "signmaker_sec"
	set_items = list(
		/obj/item/holosign_creator/security,
		)

/datum/voucher_set/security/utility/lawbook
	name = "Weighted Space Law Book"
	description = "A special edition release of Nanotrasen Space Law. The decorative metal cover adds quite the amount of bulk... Be careful swinging it."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "SpaceLawWeighted"
	set_items = list(
		/obj/item/book/manual/wiki/security_space_law/weighted,
		)

/datum/voucher_set/security/utility/donut_box
	name = "Box of Donuts"
	description = "Tantalizing..."
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donutbox"
	set_items = list(
		/obj/item/storage/fancy/donut_box,
		/obj/item/reagent_containers/cup/glass/coffee,
		)

/datum/voucher_set/security/utility/barrier
	name = "Barrier Grenades"
	description = "Two barrier grenades."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "wallbang"
	set_items = list(
		/obj/item/grenade/barrier,
		/obj/item/grenade/barrier,
		)

/datum/voucher_set/security/utility/stingbang
	name = "Stingbang Grenades"
	description = "Two stingbang grenades."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "timeg_locked"
	set_items = list(
		/obj/item/grenade/stingbang,
		/obj/item/grenade/stingbang,
		)

/datum/voucher_set/security/utility/justice_helmet
	name = "Helmet of Justice"
	description = "Crime fears the helmet of justice."
	icon = 'icons/obj/clothing/head/helmet.dmi'
	icon_state = "justice"
	set_items = list(
		/obj/item/clothing/mask/gas/sechailer/swat,
		/obj/item/clothing/head/helmet/toggleable/justice,
		)

/datum/voucher_set/security/utility/pinpointer_pairs
	name = "Pinpointer Pair"
	description = "A pair of handheld tracking devices that lock onto the other half of the matching pair."
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "pinpointer"
	set_items = list(
		/obj/item/storage/box/pinpointer_pairs,
		)

/datum/voucher_set/security/utility/laptop
	name = "Security Laptop"
	description = "A laptop pre-loaded with security software."
	icon = 'icons/obj/devices/modular_laptop.dmi'
	icon_state = "laptop-closed"
	set_items = list(
		/obj/item/modular_computer/laptop/preset/security,
	)

/obj/item/modular_computer/laptop/preset/security
	starting_programs = list(
		/datum/computer_file/program/chatclient,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/secureye,
	)
