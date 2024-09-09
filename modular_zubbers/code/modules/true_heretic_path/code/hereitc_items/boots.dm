/obj/item/clothing/shoes/workboots/speed
	name = "boots of speed"
	desc = "A fancy pair of green workboots, with some crude paper wings attached. The paper makes it more aerodynamic."
	slowdown = -0.15

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	icon_state = "boots_of_speed"

	worn_icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_worn.dmi'
	worn_icon_state = "boots_of_speed"

/obj/item/clothing/shoes/workboots/speed/Initialize(...)
	ADD_TRAIT(src, TRAIT_INNATELY_FANTASTICAL_ITEM,EXILE_UNIQUE)
	. = ..()