/obj/machinery/vending/access/command/build_access_list(list/access_lists)
	. = ..()
	access_lists["[ACCESS_CAPTAIN]"] += list(
		/obj/item/clothing/head/hats/warden/drill/captain = 1,
		/obj/item/clothing/head/hats/warden/drill/blueshield = 1,
		/obj/item/clothing/under/rank/captain/dress = 1,
		/obj/item/clothing/under/rank/blueshield/netra = 1,
		/obj/item/clothing/gloves/netra = 1, //These are meant to go with the dress above it.
		/obj/item/clothing/under/bimpcap = 1,
	)

	access_lists["[ACCESS_HOS]"] += list(
		/obj/item/clothing/head/hats/warden/drill/hos = 1,
		/obj/item/clothing/under/rank/security/head_of_security/alt/roselia = 1,
		/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia = 1,
		/obj/item/clothing/head/hats/hos/elofy = 1,
		/obj/item/clothing/suit/armor/hos/elofy = 1,
		/obj/item/clothing/gloves/elofy = 1, //Part of a set so...
		/obj/item/clothing/shoes/jackboots/elofy = 1,
	)

	access_lists["[ACCESS_CENT_GENERAL]"] += list(
		/obj/item/clothing/head/hats/warden/drill/nanotrasen = 1,
		/obj/item/clothing/under/rank/nanotrasen_consultant/stripper = 1,
		/obj/item/clothing/under/nt_idol_skirt = 1,
		/obj/item/clothing/head/nanotrasen_consultant/hubert = 1,
		/obj/item/clothing/suit/armor/vest/nanotrasen_consultant/hubert = 1,
		/obj/item/clothing/under/rank/nanotrasen_consultant/hubert = 1,
		/obj/item/clothing/head/razurathhat = 1,
		/obj/item/clothing/suit/razurathcoat = 1,
		/obj/item/clothing/head/playbunnyears/centcom = 1,
		/obj/item/clothing/neck/tie/bunnytie/centcom = 1,
		/obj/item/clothing/suit/jacket/tailcoat/centcom = 1,
		/obj/item/clothing/under/costume/playbunny/centcom = 1,
	)

	access_lists["[ACCESS_COMMAND]"] += list(
		/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper = 5, //Multiple for heads. Urgh.
		/obj/item/clothing/suit/armor/skyy = 2,
	)

