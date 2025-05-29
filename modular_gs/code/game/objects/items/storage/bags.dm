/obj/item/storage/bag/tray/holding
	name = "serving tray of holding"
	desc = "A tray for food, now featuring bluesapce technology. Don't ask."

/obj/item/storage/bag/tray/holding/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = INFINITY
	STR.max_items = 50

/datum/design/tray_holding
	name = "Serving Tray of Holding"
	desc = "A serving tray for food, now somehow using bluespace to hold more stuff."
	id = "tray_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 250, /datum/material/uranium = 500)
	build_path =/obj/item/storage/bag/tray/holding
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/obj/item/borg/upgrade/tray_hold
	name = "cyborg tray of holding"
	desc = "A tray of holding replacement for service borg's tray."
	icon_state = "cyborg_upgrade3"
	require_module = 1
	module_type = /obj/item/robot_module/butler

/obj/item/borg/upgrade/tray_hold/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/storage/bag/tray/holding/S = new(R.module)
		R.module.basic_modules += S
		R.module.add_module(S, FALSE, TRUE)

/obj/item/borg/upgrade/tray_hold/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		var/obj/item/storage/bag/tray/holding/S = locate() in R.module
		R.module.remove_module(S, TRUE)

/datum/design/borg_tray_hold
	name = "Cyborg Tray of Holding"
	id = "borg_tray_hold"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tray_hold
	materials = list(/datum/material/gold = 250, /datum/material/uranium = 500)
	construction_time = 100
	category = list("Cyborg Upgrade Modules")
