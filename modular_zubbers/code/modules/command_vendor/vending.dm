/obj/machinery/vending/access/command/build_access_list(list/access_lists)
	. = ..()
	access_lists["[ACCESS_CAPTAIN]"] += list(
		/obj/item/clothing/head/hats/warden/drill/captain = 1,
		/obj/item/clothing/head/hats/warden/drill/blueshield = 1,
	)

	access_lists["[ACCESS_HOS]"] += list(
		/obj/item/clothing/head/hats/warden/drill/hos = 1,
	)

	access_lists["[ACCESS_CENT_GENERAL]"] += list(
		/obj/item/clothing/head/hats/warden/drill/nanotrasen = 1,
		/obj/item/clothing/under/rank/nanotrasen_consultant/stripper = 1,
	)

	access_lists["[ACCESS_COMMAND]"] += list(
		/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper = 5, //Multiple for heads. Urgh.
	)

