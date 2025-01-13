/obj/item/mod/control/pre_equipped/nuclear/chameleon/Initialize(mapload, new_theme, new_skin, new_core)
	applied_modules += /obj/item/mod/module/chameleon
	. = ..()

/obj/item/mod/control/pre_equipped/asset_protection
	theme = /datum/mod_theme/asset_protection
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/status_readout,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
	)
