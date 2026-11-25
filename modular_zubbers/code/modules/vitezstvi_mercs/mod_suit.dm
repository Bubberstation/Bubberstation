/obj/item/mod/control/pre_equipped/frontline/ert/vitezstvi
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/medbeam,
	)
	default_pins = list(
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/medbeam,
	)

/obj/item/mod/control/pre_equipped/frontline/ert/vitezstvi/Initialize(mapload)
	. = ..()
	// no hat stabilizer, so berets sit under the helmet instead of falling off
	for(var/obj/item/part as anything in get_parts())
		qdel(part.GetComponent(/datum/component/hat_stabilizer))
