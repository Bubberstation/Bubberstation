/obj/item/scrap/toilet_paper
	icon_state = "toilet_paper"
	name = "toilet paper"
	desc = "Straight from the office! This is worthless."
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'

/obj/item/scrap/toilet_paper/randomize_credit_cost()
	return rand(60, 80)
