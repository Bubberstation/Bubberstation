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
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	icon_state = "seva"
	set_items = list(
		/obj/item/clothing/suit/hooded/seva,
		/obj/item/clothing/mask/gas/seva,
	)
