/obj/item/gun/energy/laser/lmg //i don't care enough to finish this but maybe it'll be useful as an ert gun idk
	name = "\improper Type 3x3 laser machine gun"
	desc = "The Type 3x3 Heat Delivery System, developed by Nanotrasen. Identical in performance to it's little brother, but with a much bigger capacity."
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "assault_laser"
	inhand_icon_state = "assault_laser"
	worn_icon_state = "assault_laser"
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	cell_type = /obj/item/stock_parts/power_store/cell/laser_lmg
	shaded_charge = TRUE
	light_color = COLOR_SOFT_RED
	spread = 5

/obj/item/gun/energy/laser/lmg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.20 SECONDS)

// Mmmm Lore //

/obj/item/gun/energy/laser/lmg/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The NT Type 3x3 Heat Delivery System (sometimes referred to as the HDS-3x3 or HDS-9 in promotional material) is what happens when \
		you put a bigger cell into a modified Type 3.<br>\
		<br>\
		Despite performing nearly identically to the Type 3, it's typically found more on tripods more as an emplacement than a hand-held weapon. \
		While it does see some use with various degrees of militants, private security, or those looking for the ability of high sustained fire, \
		the bulky construction to house it's expanded cell, and the relatively slow recharge rate of the internal cell renders it a bit cumbersome to use.<br> \
		<br>\
		However, those who have used it will swear by it that it lays down enough laser to make it all worthwhile." \
	)
