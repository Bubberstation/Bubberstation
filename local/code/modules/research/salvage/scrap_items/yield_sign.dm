/obj/item/scrap/yield
	icon_state = "yield0"
	name = "yield sign"
	desc = "For an unyielding beatdown."
	force = 10
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 10
	demolition_mod = 0.75
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	attack_verb_continuous = list("attacks", "smacks", "whacks", "thwacks")
	attack_verb_simple = list("attack", "smack", "whack", "thwack")
	pickup_sound = 'sound/items/handling/materials/metal_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'

/obj/item/scrap/yield/randomize_credit_cost()
	return rand(18, 36)

/obj/item/scrap/yield/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = initial(force), \
		force_wielded = 20, \
		icon_wielded = "yield1", \
	)

/obj/item/scrap/yield/update_icon_state()
	icon_state = "yield0"
	return ..()
