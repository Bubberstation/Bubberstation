/obj/item/clothing/under/misc/diver //Donor item for patriot210
	name = "black divers uniform"
	desc = "An old exploration uniform used by a now-defunct mining coalition, even after all this time, it still fits."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "diver"
	worn_icon_state = "diver"
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	body_parts_covered = CHEST|LEGS|GROIN

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/under/costume/playbunny
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/costume/playbunny/greyscale
	name = "bunny suit"
	desc = "The staple of any bunny themed waiters and the like. It has a little cottonball tail too."
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/playbunny/greyscale"
	post_init_icon_state = "playbunny"
	greyscale_colors = "#39393f#39393f#ffffff#87502e"
	greyscale_config = /datum/greyscale_config/bunnysuit
	greyscale_config_worn = /datum/greyscale_config/bunnysuit_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/playbunny/custom_playbunny
	name = "tailormade bunny suit"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/playbunny/custom_playbunny"
	post_init_icon_state = "playbunny"
	greyscale_colors = "#373768#c9c9c9#ababcd#880088"
	greyscale_config = /datum/greyscale_config/custom_bunnysuit
	greyscale_config_worn = /datum/greyscale_config/custom_bunnysuit_worn
	greyscale_config_worn_digi = /datum/greyscale_config/custom_bunnysuit_worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	flags_1 = IS_PLAYER_COLORABLE_1

// BUNNY STUFF END

/obj/item/clothing/under/rank/civilian/microstar_suit
	name = "\improper MicroStar SCI-MED suit"
	desc = "A non-spaceproof partial pressure suit manufactured by MicroStar Inc; designed for maximum comfort, safety, and enhancement of productivity. Its proprietary helmet seems to be missing."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	icon = 'modular_zubbers/icons/obj/clothing/under/scimed_suit.dmi'
	icon_state = "scimed_suit"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/scimed_suit.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/scimed_suit_digi.dmi'
	inhand_icon_state = "w_suit"
	can_adjust = FALSE
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg'
	/*
	lefthand_file = 'modular_zubbers/icons/mob/inhands/clothing/scimed_suit_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/clothing/scimed_suit_righthand.dmi'
	*/

/obj/item/clothing/under/costume/loincloth
	name = "loincloth"
	desc = "A simple leather covering. It's better than wearing nothing at least."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "loincloth"
	body_parts_covered = GROIN
	can_adjust = FALSE
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/loincloth/sensor
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/costume/loincloth/cloth
	desc = "A simple cloth covering. It's better than wearing nothing at least."
	icon_state = "loincloth_cloth"

/obj/item/clothing/under/costume/loincloth/cloth/sensor
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/costume/lizardgas
	name = "lizard gas uniform"
	desc = "A purple shirt with a nametag, and some ill-fitting jeans. The bare minimum required by company standards."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "lizardgas"
	body_parts_covered = CHEST|GROIN|LEGS
	has_sensor = NO_SENSORS //you're not NT employed, so they don't care about you

/obj/item/clothing/under/costume/allamerican
	name = "all-american diner employee uniform"
	desc = "A salmon colored short-sleeved dress shirt with a white nametag, bearing the name of the employee. Along with some snazzy dark grey slacks, a formal attire for a classy joint."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "allamerican"
	body_parts_covered = CHEST|GROIN|LEGS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE

/obj/item/clothing/under/costume/allamerican/manager
	name = "all-american diner manager uniform"
	desc = "A salmon colored long-sleeved dress shirt with a white nametag, bearing the name of the employee. Along with some snazzy dark grey slacks held up by a belt with a gold buckle, a formal attire for a classy joint."
	icon_state = "allamerican_manager"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/under/red_and_white_collared_outfit
	desc = "An outfit that screams 'I've never killed anyone!', which is probably true."
	name = "red and white collared outfit"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "whiteandred_kiryulmfao"
	worn_icon_state = "whiteandred_kiryulmfao"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/costume/hlciv
	name = "blue citizen uniform"
	desc = "Sometimes, I dream about cheese."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "citizenblue"

//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.

/obj/item/clothing/under/rank/civilian/bubber/snake
	name = "big boss' stealth suit"
	desc = "We may all be headed straight to hell. But what better place for us than this?"
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "snake"

/obj/item/clothing/under/rank/civilian/bubber/camo
	name = "camouflage uniform"
	desc = "Well my wife left me, so now I make stolen valor videos at the mall."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/bubber/camo"
	post_init_icon_state = "solfed_camo"
	worn_icon_state = "solfed_camo"
	worn_icon_digi = "solfed_camo"
	greyscale_config = /datum/greyscale_config/camo
	greyscale_config_worn = /datum/greyscale_config/camo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/camo/worn/digi
	greyscale_colors = "#4d4d4d#333333#292929"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE
