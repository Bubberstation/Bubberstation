/obj/item/ammo_casing/shotgun
	var/box_sprite = SHELL_BOX_SPRITE_N
	// "#sleeve#hulls#emblem", or one color and the box works out the rest
	var/box_colors = "#c8c8c8"

/obj/item/ammo_casing/shotgun/junk
	name = "improvised shell"
	desc = "A homemade shotgun casing filled with crushed glass, used to commit vandalism and property damage."
	icon_state = "improvshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_improvised
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1)
	pellets = 6
	variance = 30
	can_be_printed = FALSE

/obj/item/ammo_casing/shotgun/milspec
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 1)

/obj/item/ammo_casing/shotgun/buckshot/milspec
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 1)

/obj/item/ammo_casing/shotgun/executioner
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 1)

/obj/item/ammo_casing/shotgun/pulverizer
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/ammo_casing/shotgun/incendiary/no_trail
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 1)

/obj/item/ammo_casing/shotgun/stunslug
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 1, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1)

/obj/item/ammo_casing/shotgun/buckshot/spent
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2)
