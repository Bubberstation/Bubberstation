//modularizing because i want my code to exist
/obj/item/stock_parts/power_store/cell/crystal_cell
	name = "crystal power cell"
	desc = "A very high power cell made from crystallized plasma"
	icon_state = "crystal_cell"
	maxcharge = STANDARD_CELL_CHARGE * 20 // maxcharge 50* to 20*, 50% a bluespace cell max-charge.
	emp_damage_modifier = STANDARD_CELL_CHARGE * 20 // should hopefully guarentee full depowerment on EMP. increased from default of 1
	chargerate = 10 * STANDARD_CELL_RATE // chargerate 0 > 10* standard, gives the cell an actual niche instead of being a worse xenobio overcharged core
	charge_light_type = null
	connector_type = "crystal"
	custom_materials = null

/obj/item/stock_parts/power_store/cell/high/slime_hypercharged
	name = "hypercharged slime core"
	desc = "A charged yellow slime extract, infused with plasma."
	icon = 'icons/mob/simple/slimes.dmi'
	icon_state = "yellow-core"
	rating = 7
	custom_materials = null
	maxcharge = 30 * STANDARD_CELL_CHARGE // 30 down from 50, 300kJ - on-par with hyper-capacity cells.
	chargerate = 0.5 * STANDARD_CELL_RATE // chargerate reduced down from 2.5* to 0.5* standard.
	emp_damage_modifier = 0 // biological cell. gains a gimmick present in the other yellow cell. post-rebalance this makes it actually useful instead of just a raw improvement over bluespace cells
	charge_light_type = null
	connector_type = "slimecore"

/obj/item/stock_parts/power_store/cell/lead
	name = "lead-acid battery"
	desc = "A primitive battery. It is quite large and feels unexpectedly heavy."
	icon = 'icons/obj/maintenance_loot.dmi'
	icon_state = "lead_battery"
	force = 10 // double the force of a normal cell
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	maxcharge = STANDARD_CELL_CHARGE * 100 // 600kJ up to 1mJ, its original value
	chargerate = STANDARD_CELL_RATE * 0.2 // charging reduced from 70% reduction to 80%
	emp_damage_modifier = 5 // slight increase, 4 to 5.
	charge_light_type = null
	connector_type = "leadacid"

/obj/item/stock_parts/power_store/cell/lead/grind_results()
	return list(/datum/reagent/lead = 15, /datum/reagent/toxin/acid = 15, /datum/reagent/water = 20)

//starts partially discharged
/obj/item/stock_parts/power_store/cell/lead/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	var/initial_percent = rand(20, 50) / 100 // 200kJ to 500kJ
	charge = initial_percent * maxcharge
	ADD_TRAIT(src, TRAIT_FISHING_BAIT, INNATE_TRAIT)
	AddComponent(/datum/component/loads_avatar_gear, \
		load_callback = CALLBACK(src, PROC_REF(shockingly_improve_avatar)), \
	)
