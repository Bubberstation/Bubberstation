/obj/item/gun/energy/e_gun/revolver //The gun fit for a kitsune
	name = "X-R12 energy revolver" //BUBBER EDIT pretty much the whole file is just bubber edit
	desc = "An experimental model advanced energy weapon with the capacity to shoot both electrodes and lasers, used by many private defense contractors from Romulus to New Moscow, its also rather heavy and would certainly hurt to get pistol whipped by." //BUBBER EDIT
	force = 12
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/blueshield, /obj/item/ammo_casing/energy/electrode/blueshield)
	ammo_x_offset = 1
	charge_sections = 4
	fire_delay = 4
	icon = 'modular_zubbers/icons/obj/reshirevolver.dmi' //BUBBER EDIT
	icon_state = "bsalt" //BUBBER EDIT
	inhand_icon_state = "minidisable"
	lefthand_file = 'modular_skyrat/modules/blueshield/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/blueshield/icons/guns_righthand.dmi'
	obj_flags = UNIQUE_RENAME
	cell_type = /obj/item/stock_parts/cell/blueshield
	//RESTORE FUNCTIONALITY AS NEEDED BUBBER EDIT pin = /obj/item/firing_pin/implant/mindshield
	selfcharge = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	worn_icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_back.dmi'
	worn_icon_state = "bsrevolver" //BUBBER EDIT
	company_flag = COMPANY_ROMULUS //BUBBER EDIT

/obj/item/stock_parts/cell/blueshield //BUBBER EDIT
	name = "internal revolver power cell"
	maxcharge = 1200
	chargerate = 105 //Hit your shot and don't complain, it's self recharging.

/obj/item/gun/energy/e_gun/revolver/pdw9 //The gun fit for a real man
	name = "PDW-9 taser pistol"
	desc = "A military grade energy sidearm, used by many militia forces throughout the local sector. It comes with an internally recharging battery which is slow to recharge."
	ammo_x_offset = 2
	icon_state = "pdw9pistol"
	inhand_icon_state = null
	cell_type = /obj/item/stock_parts/cell/pdw9

/obj/item/stock_parts/cell/pdw9
	name = "internal pistol power cell"
	maxcharge = 1400
	chargerate = 300
	var/obj/item/gun/energy/e_gun/revolver/pdw9/parent

/obj/item/stock_parts/cell/pdw9/Initialize(mapload)
	. = ..()
	parent = loc

/obj/item/stock_parts/cell/pdw9/process()
	. = ..()
	parent.update_icon()
