/obj/item/mod/control/pre_equipped/asset_protection
	worn_icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "asset_protection-control"
	theme = /datum/mod_theme/asset_protection
	applied_cell = /obj/item/stock_parts/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/projectile_dampener,
<<<<<<< HEAD
		/obj/item/mod/module/status_readout,
=======
		/obj/item/mod/module/status_readout/generic,
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
	)
