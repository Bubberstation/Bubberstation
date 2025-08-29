//Rating 5 - These are exclusive to scrap piles and are NOT station printable. If /tg/ implements tier 5 stock parts on their own this may need reassessment.

/obj/item/stock_parts/capacitor/experimental
	name = "experimental capacitor"
	desc = "a top-of-it's-class capacitor used in the construction of a variety of devices."
	icon = 'local/icons/obj/devices/stock_parts.dmi'
	icon_state = "experimental_capacitor"
	rating = 5
	energy_rating = 15
	custom_materials = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT, /datum/material/glass=SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/scanning_module/prototype
	name = "prototype scanning module"
	desc = "A micro-sized, hyper-resolution scanning module used in the construction of certain devices."
	icon = 'local/icons/obj/devices/stock_parts.dmi'
	icon_state = "prototype_scan_module"
	rating = 5
	energy_rating = 15
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT, /datum/material/plasma=SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/servo/atomic
	name = "atomic servo"
	desc = "A thumb-sized servo motor used in the construction of certain devices."
	icon = 'local/icons/obj/devices/stock_parts.dmi'
	icon_state = "atomic_servo"
	rating = 5
	energy_rating = 15
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT, /datum/material/uranium=SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/micro_laser/quintuple_bound
	name = "quintuple-bound micro-laser"
	desc = "A teeny laser used in certain devices."
	icon = 'local/icons/obj/devices/stock_parts.dmi'
	icon_state = "quintuple_bound_micro_laser"
	rating = 5
	energy_rating = 15
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT, /datum/material/glass=SHEET_MATERIAL_AMOUNT)

/obj/item/stock_parts/matter_bin/anomic // Built around a BS Anomaly Core; was my thought
	name = "anomic matter bin"
	desc = "A container designed to hold ultra-compressed matter awaiting reconstruction."
	icon = 'local/icons/obj/devices/stock_parts.dmi'
	icon_state = "anomic_matter_bin"
	rating = 5
	energy_rating = 15
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT, /datum/material/bluespace=SHEET_MATERIAL_AMOUNT)
