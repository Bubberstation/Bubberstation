/obj/item/clothing/under/misc/diver //Donor item for patriot210
	name = "black divers uniform"
	desc = "An old exploration uniform used by a now-defunct mining coalition, even after all this time, it still fits."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "diver"
	worn_icon_state = "diver"
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	body_parts_covered = CHEST|LEGS|GROIN

/obj/item/clothing/under/costume/playbunny
	name = "bunny suit"
	desc = "The staple of any bunny themed waiters and the like. It has a little cottonball tail too."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "playbunny"
	greyscale_colors = "#39393f#39393f#ffffff#87502e"
	greyscale_config = /datum/greyscale_config/bunnysuit
	greyscale_config_worn = /datum/greyscale_config/bunnysuit_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/costume/playbunny/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/under/syndicate/syndibunny //heh
	name = "blood-red bunny suit"
	desc = "The staple of any bunny themed syndicate assassins. Are those carbon nanotube stockings?"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "syndibunny"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/under/syndicate/syndibunny/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/small)

/obj/item/clothing/under/syndicate/syndibunny/fake
	armor_type = /datum/armor/clothing_under/none

/obj/item/clothing/under/costume/playbunny/magician
	name = "magician's bunny suit"
	desc = "The staple of any bunny themed stage magician."
	icon_state = "playbunny_wiz"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/magician/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny/magician)

/datum/storage/pockets/tiny/magician/New() //this is probably a good idea
	. = ..()
	var/static/list/exception_cache = typecacheof(list(
		/obj/item/gun/magic/wand,
		/obj/item/warp_whistle,
	))
	exception_hold = exception_cache

/obj/item/clothing/under/costume/playbunny/centcom
	name = "centcom bunnysuit"
	desc = "A modified Centcom version of a bunny outfit, using Lunarian technology to condense countless amounts of rabbits into a material that is extremely comfortable and light to wear."
	icon_state = "playbunny_centcom"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/british
	name = "british bunny suit"
	desc = "The staple of any bunny themed monarchists. It has a little cottonball tail too."
	icon_state = "playbunny_brit"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/communist
	name = "really red bunny suit"
	desc = "The staple of any bunny themed communists. It has a little cottonball tail too."
	icon_state = "playbunny_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/usa
	name = "striped bunny suit"
	desc = "A bunny outfit stitched together from several American flags. It has a little cottonball tail too."
	icon_state = "playbunny_usa"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
