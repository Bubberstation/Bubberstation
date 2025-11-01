/obj/item/scrap/tattered_sheet_metal
	icon_state = "tattered_sheet_metal"
	name = "tattered sheet metal"
	desc = "For when regular metal doesn't suffice."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	pickup_sound = 'sound/items/handling/materials/metal_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'

/obj/item/scrap/tattered_sheet_metal/randomize_credit_cost()
	return rand(10, 22)
