/datum/storage/surgery_tray/New()
	. = ..()
	add_holdable(list(
		/obj/item/reagent_containers/medigel/sterilizine,
		/obj/item/clothing/suit/toggle/labcoat/hospitalgown,
		/obj/item/storage/pill_bottle/lidocaine,
		)
	)

/datum/storage/wallet/New()
	. = ..()
	add_holdable(list(
		/obj/item/condom_pack,
		/obj/item/gbp_punchcard,
		)
	)

