// Printable permit HUD, mirroring the other Integrated HUDs designs so it isn't a magic item locked to the blacksmith's loadout.
/datum/design/permit_hud
	name = "Permit HUD"
	desc = "A basic heads-up display that scans humanoids in view and flags whether their ID carries a firearms permit."
	id = "permit_hud"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/clothing/glasses/hud/permit
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
