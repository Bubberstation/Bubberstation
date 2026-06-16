/obj/item/stock_parts/power_store/battery/crystal_cell
	name = "Crystal megacell"
	desc = "A rechargeable, solid-state plasma crystal megacell."
	icon_state = "crystal_cell"
	maxcharge = STANDARD_BATTERY_CHARGE * 20
	chargerate = STANDARD_BATTERY_RATE * 4
	emp_damage_modifier = STANDARD_CELL_CHARGE * 20 // should hopefully guarentee full depowerment on EMP
	charge_light_type = null
	connector_type = "crystal"
	custom_materials = null


/obj/item/stock_parts/power_store/battery/crystal_cell/grind_results()
	return null

/obj/item/stock_parts/power_store/battery/lead
	name = "lead-acid cell array"
	desc = "a heavy array of lead-acid batteries."
	icon = 'icons/obj/maintenance_loot.dmi'
	icon_state = "lead_battery"
	force = 10 // double the force of a normal cell
	throwforce = 10
	w_class = WEIGHT_CLASS_BULKY
	maxcharge = STANDARD_BATTERY_CHARGE * 100 // FAT fucking megacell.
	chargerate = STANDARD_BATTERY_RATE * 0.05 // basically unable to do anything but tricke charge in/out, though.
	emp_damage_modifier = 10 // its literally multiple car batteries wired together
	charge_light_type = null
	connector_type = "leadacid"

/obj/item/stock_parts/power_store/battery/lead/grind_results()
	return list(/datum/reagent/lead = 80, /datum/reagent/copper = 25, /datum/reagent/iron = 20) // the cells have been dried, no more soggy battery

/obj/item/stock_parts/power_store/battery/lead/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	var/initial_percent = rand(20, 50) / 100 // 200kJ to 500kJ
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_unwielded = 12, force_wielded = 12) // BIG, use two hands.
	charge = initial_percent * maxcharge
