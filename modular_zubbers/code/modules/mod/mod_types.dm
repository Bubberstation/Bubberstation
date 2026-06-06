/obj/item/mod/control/pre_equipped/apocryphal
	applied_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/headprotector,
		/obj/item/mod/module/longfall,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/anti_magic,
		/obj/item/mod/module/visor/medhud,
		/obj/item/mod/module/eradication_lock,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/eradication_lock,
		/obj/item/mod/module/visor/medhud,
	)

/obj/item/mod/control/pre_equipped/apocryphal/officer
	applied_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/hat_stabilizer,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/headprotector,
		/obj/item/mod/module/longfall,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/anti_magic,
		/obj/item/mod/module/visor/medhud,
		/obj/item/mod/module/eradication_lock,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/power_kick,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/eradication_lock,
		/obj/item/mod/module/visor/medhud,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/power_kick,
	)

/obj/item/mod/control/pre_equipped/asset_protection
	worn_icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "asset_protection-control"
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

/obj/item/mod/control/pre_equipped/lustwish
	worn_icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_lustwish.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_lustwish.dmi'
	icon_state = "lustwish-control"
	theme = /datum/mod_theme/lustwish

//Hat Stabilizer Module added as default module to the Blueshield and Safeguard Modsuits
/obj/item/mod/control/pre_equipped/blueshield/New()
	applied_modules += list(
		/obj/item/mod/module/hat_stabilizer,
	)
	return ..()

/obj/item/mod/control/pre_equipped/safeguard/New()
	applied_modules += list(
		/obj/item/mod/module/hat_stabilizer,
	)
	return ..()
