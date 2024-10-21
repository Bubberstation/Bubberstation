/obj/item/clothing/mask/gas/bubber //Saves having to type the icon stuff, means you just type in the state, smiley face emoji heart
	name = "EMERGENCY!!"
	desc = "The next 72 hours are going to be dangerous."
	icon = 'modular_zubbers/icons/obj/clothing/mask/mask.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/mask/mask.dmi'
	icon_state = null

//Sprites from Sojourn Station: https://github.com/sojourn-13/sojourn-station

/obj/item/clothing/mask/gas/bubber/clown
	name = "coloured clown mask"
	desc = "After a painful 48 year delay, the matching non-ginger Clown masks have arrived! Shoes are still in transit."
	clothing_flags = MASKINTERNALS
	icon_state = "redclown"
	dye_color = DYE_CLOWN
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust)
	dog_fashion = /datum/dog_fashion/head/clown
	obj_flags = parent_type::obj_flags | INFINITE_RESKIN
	unique_reskin = list(
			"Down Clown" = "blueclown",
			"Jumbo" = "greenclown",
			"Stepchild" = "redclown",
			"Banana Brained" = "yellowclown",
			"Rhubarb Rubber" = "purpleclown"
	)

/obj/item/clothing/mask/gas/bubber/clown/reskin_obj(mob/user)
	. = ..()
	user.update_worn_mask()
	voice_filter = null // performer masks expect to be talked through


/obj/item/clothing/mask/gas/half_mask
	name = "tacticool neck gaiter"
	desc = "A black techwear mask. Its low-profile design contrasts with the edge. Has a small respirator to be used with internals."
	actions_types = list(/datum/action/item_action/adjust)
	alternate_worn_layer = BODY_FRONT_UNDER_CLOTHES
	icon_state = "half_mask"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	unique_death = 'modular_skyrat/master_files/sound/effects/hacked.ogg'
	voice_filter = null
	use_radio_beeps_tts = FALSE

/obj/item/clothing/mask/gas/half_mask/ui_action_click(mob/user, action)
	adjust_visor(user)
