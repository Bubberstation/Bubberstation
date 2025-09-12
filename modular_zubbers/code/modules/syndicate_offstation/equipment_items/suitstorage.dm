//Various offstation syndicate mapping bits for bubber

/obj/machinery/suit_storage_unit/industrial/bloodredsuit
	mod_type = /obj/item/mod/control/pre_equipped/traitor
	storage_type = /obj/item/tank/internals/emergency_oxygen/double
	mask_type = /obj/item/clothing/mask/gas/syndicate

/obj/machinery/suit_storage_unit/industrial/syndicatemining
	suit_type = /obj/item/clothing/suit/hooded/explorer/syndicate
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/industrial/syndicatecontractor
	mod_type = /obj/item/mod/control/pre_equipped/contractor
	storage_type = /obj/item/tank/internals/emergency_oxygen/double
	mask_type = /obj/item/clothing/mask/gas/syndicate

/obj/machinery/suit_storage_unit/industrial/moraleofficer
	mod_type = /obj/item/mod/control/pre_equipped/nuclear/honkerative
	storage_type = /obj/item/tank/internals/emergency_oxygen/double
	mask_type = /obj/item/clothing/mask/gas/syndicate

/obj/machinery/suit_storage_unit/industrial/commsoperative
	mod_type = /obj/item/mod/control/pre_equipped/infiltrator/persistence

	storage_type = /obj/item/tank/internals/emergency_oxygen/double
	mask_type = /obj/item/clothing/mask/gas/syndicate

//Modsuit loadouts

//morale officer suit
/obj/item/mod/control/pre_equipped/nuclear/honkerative
	applied_skin = "honkerative"
	theme = /datum/mod_theme/syndicate
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	req_access = list(ACCESS_SYNDICATE)
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/jump_jet,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/hat_stabilizer/syndicate,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/waddle,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/jump_jet,
	)

/obj/item/mod/control/pre_equipped/infiltrator/persistence
	theme = /datum/mod_theme/infiltrator/persistence
	applied_modules = list(
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/hat_stabilizer/syndicate,
		/obj/item/mod/module/quick_cuff,
	)

//Empty infiltrator MOD for the Syndicate Boarder preview
/obj/item/mod/control/pre_equipped/empty/infiltrator/preview_only
	theme = /datum/mod_theme/infiltrator/preview_only

//Making this so it has no modules
/datum/mod_theme/infiltrator/preview_only
	inbuilt_modules = list()
	slot_flags = ITEM_SLOT_BACK

