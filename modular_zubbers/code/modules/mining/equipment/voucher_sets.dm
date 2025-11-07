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
