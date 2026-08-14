/obj/item/crowbar/large/heavy/science
	name = "physicist's crowbar"
	desc = "It's a big crowbar for a scientist who is clearly compensating for something. It doesn't fit in your pockets, because it's big. Feels oddly light..."
	force = 4 // ~3 times less
	throwforce = 12
	attack_speed = CLICK_CD_RAPID //4 times faster.

	toolspeed = 0.25
	demolition_mod = 2
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		)
