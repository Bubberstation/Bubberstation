/*
*	SUITS
*/
/obj/item/clothing/suit/bio_suit/security
	desc = "A suit that protects against biological contamination. This is a slightly outdated model from Nanotrasen Securities, using their red color-scheme and even outdated labelling. Hopefully it's still up to spec..."
	//To recolor this would be hellish and honestly non-sensical. So, Nanotrasen Securities' bio-suit. Plus, flavor!

/*
*	HEAD
*/
/obj/item/clothing/head/bio_hood/security
	desc = "A hood that protects the head and face from biological contaminants. This is a slightly outdated model from Nanotrasen Securities - you can hardly see through the foggy visor's ageing red. Hopefully it's still up to spec..."
	//To recolor this would be hellish and honestly non-sensical. So, Nanotrasen Securities' bio-suit. Plus, flavor!

/obj/item/clothing/head/costume/weddingveil
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	//TG's is ugly as sin, until it's updated we have our own

/obj/item/clothing/head/pelt
	name = "bear pelt"
	desc = "A luxurious bear pelt, good to keep warm in winter. Or to sleep through it."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "bearpelt_brown"
	inhand_icon_state = "cowboy_hat_brown"
	cold_protection = CHEST|HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/pelt/black
	icon_state = "bearpelt_black"
	inhand_icon_state = "cowboy_hat_black"

/obj/item/clothing/head/pelt/white
	icon_state = "bearpelt_white"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/wolf
	name = "wolf pelt"
	desc = "A fuzzy wolf pelt that demands respect as a hunter... assuming it wasn't just purchased, that is, for all the glory but none of the credit."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/pelt_big.dmi'
	icon_state = "wolfpelt_brown"

/obj/item/clothing/head/pelt/wolf/black
	icon_state = "wolfpelt_gray"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/wolf/white
	icon_state = "wolfpelt_white"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/tiger
	name = "shiny tiger pelt"
	desc = "A vibrant tiger pelt, particularly fabulous."
	icon_state = "tigerpelt_shiny"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/snow_tiger
	name = "snow tiger pelt"
	desc = "A pelt of a less vibrant tiger, but rather warm."
	icon_state = "tigerpelt_snow"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/pink_tiger
	name = "pink tiger pelt"
	desc = "A particularly vibrant tiger pelt, for those who want to be the most fabulous at parties."
	icon_state = "tigerpelt_pink"
	inhand_icon_state = "cowboy_hat_red"

/*
*	SHOES
*/

/obj/item/clothing/shoes/workboots/old
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	icon_state = "workbootsold"


/*
*	UNDERSUITS
*/

/obj/item/clothing/under/rank/rnd/research_director/turtleneck
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'

