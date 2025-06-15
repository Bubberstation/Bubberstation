/datum/storage/medical_belt/New()
	. = ..()
	add_holdable(list(
		/obj/item/clothing/suit/toggle/labcoat/hospitalgown,
		/obj/item/hypospray/mkii,
		/obj/item/storage/hypospraykit/,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/weaponcell/medical,
		/obj/item/handheld_soulcatcher,
		)
	)
	
/datum/storage/belt/janitor/New()
	. = ..()
	var/static/list/exception_cache = typecacheof(list(
		/obj/item/storage/bag/trash,
	))
	exception_hold = exception_cache
	exception_max = 1
	allow_big_nesting = TRUE
	add_holdable(list(
		/obj/item/mop,
		/obj/item/mop/advanced,
		/obj/item/reagent_containers/cup/bucket,
		)
	)
