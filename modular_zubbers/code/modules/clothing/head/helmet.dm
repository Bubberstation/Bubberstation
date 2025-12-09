//Metro Cop stuff by HL13

/obj/item/clothing/head/helmet/metrocophelmet
	name = "civil protection helmet"
	flags_inv = HIDEHAIR | HIDEFACE | HIDESNOUT | HIDEFACIALHAIR
	desc = "Standard issue helmet for Civil Protection. Uses advanced GigaSlop brand Matrixes to allow alternative variants!"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	icon_state = "metrocopHelm"
	inhand_icon_state = null
	armor_type = /datum/armor/head_helmet
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Metrocop" = list(
			RESKIN_ICON_STATE = "metrocopHelm",
			RESKIN_WORN_ICON_STATE = "metrocopHelm"
		),
		"Medical Cop" = list(
			RESKIN_ICON_STATE = "medicalofficer",
			RESKIN_WORN_ICON_STATE = "medicalofficer"
		),
		"Green" = list(
			RESKIN_ICON_STATE = "overseer",
			RESKIN_WORN_ICON_STATE = "overseer"
		),
		"Puppet" = list(
			RESKIN_ICON_STATE = "dv_mask",
			RESKIN_WORN_ICON_STATE = "dv_mask"
		),
		"White Overwatch" = list(
			RESKIN_ICON_STATE = "overwatch_white",
			RESKIN_WORN_ICON_STATE = "overwatch_white"
		),
		"Overwatch" = list(
			RESKIN_ICON_STATE = "overwatch",
			RESKIN_WORN_ICON_STATE = "overwatch"
		),
		"Red Overwatch" = list(
			RESKIN_ICON_STATE = "overwatch_red",
			RESKIN_WORN_ICON_STATE = "overwatch_red"
		),
	)

/obj/item/clothing/head/helmet/abductor/fake
	name = "Kabrus Utility Helmet"
	desc = "A very plain helmet used by the Greys of the Kabrus Mining Site. This helmet only protects the wearer from wind and rain it seems."
	icon_state = "alienhelmet"
	inhand_icon_state = null
	armor_type = /datum/armor/none
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/helmet/toggleable/pinwheel //sprites by Keila
	name = "pinwheel hat"
	desc = "Space Jesus gives his silliest hats to his most whimsical of goobers."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "pinwheel"
	inhand_icon_state = null
	lefthand_file = null
	righthand_file = null
	armor_type = /datum/armor/none
	clothing_flags = null
	flags_cover = null
	flags_inv = null
	toggle_message = "You stop the spinner on"
	alt_toggle_message = "You spin the spinner on"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	///Cooldown for toggling the spinner.
	COOLDOWN_DECLARE(pinwheel_toggle_cooldown)

/obj/item/clothing/head/helmet/toggleable/pinwheel/adjust_visor()
	if(!COOLDOWN_FINISHED(src, pinwheel_toggle_cooldown))
		return FALSE
	COOLDOWN_START(src, pinwheel_toggle_cooldown, 1 SECONDS)
	return ..()

/obj/item/clothing/head/helmet/toggleable/pinwheel/gold
	name = "magnificent pinwheel hat"
	desc = "The strongest possible pinwheel pinwheel hat. Such is fate that the silliest things in the world are also the most beautiful; others may not see the shine in you, but the magnificent pinwheel hat does. It appreciates you for who you are and what you've done. It feels alive, and makes you feel alive too. You see the totality of existence reflected in the golden shimmer of the pin." //Does literally nothing more than the regular pinwheel hat. Just for emphasis.
	icon_state = "pinwheel_gold"


//Clussy and Jester sprites from Splurt.
/obj/item/clothing/head/costume/bubber/jester
	name = "amazing jester hat"
	desc = "It's my money, it's my game, Kill Jester."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "striped_jester_hat"

/obj/item/clothing/head/costume/bubber/clussy
	name = "pink clown wig"
	desc = "Did you know that the first Wig was made for John William Whig, founder of the Whig Party? They only allowed bald men until the year 1972, when the party became unpopular."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "clussy_wig"
	flags_inv = HIDEHAIR

// Henchmen Sprites by Cannibal Hunter of MonkeStation

/obj/item/clothing/head/henchmen_hat
	name = "henchmen cap"
	desc = "Alright boss.. I'll handle it."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/henchmen_hat"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	post_init_icon_state = "greyscale_cap"
	greyscale_colors = "#201b1a"
	greyscale_config = /datum/greyscale_config/henchmen
	greyscale_config_worn = /datum/greyscale_config/henchmen/worn
	flags_1 = IS_PLAYER_COLORABLE_1


//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/head/playbunnyears
	name = "bunny ears headband"
	desc = "A pair of bunny ears attached to a headband. One of the ears is already crooked."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/playbunnyears"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	post_init_icon_state = "playbunny_ears"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/playbunnyears
	greyscale_config_worn = /datum/greyscale_config/playbunnyears_worn
	flags_1 = IS_PLAYER_COLORABLE_1

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

//Maid SEC
/obj/item/clothing/head/security_maid //Icon by Onule!
	name = "cnc maid headband"
	desc = "A highly durable headband with the 'cleaning and clearing' insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "security_maid"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	armor_type = /datum/armor/head_helmet
	strip_delay = 60

//BEGIN HAT SPRITES BY APRIL

/obj/item/clothing/head/security_kepi
	name = "security kepi"
	desc = "Bonjour, inspecteur. A kepi police cap first popularized by planetary police on Pluto. This one appears armored."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "kepi_sec_red"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		"Red Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_red",
			RESKIN_WORN_ICON_STATE = "kepi_sec_red"
		),
		"Blue Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_blue",
			RESKIN_WORN_ICON_STATE = "kepi_sec_blue"
		),
		"White Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_white",
			RESKIN_WORN_ICON_STATE = "kepi_sec_white"
		),
		"Black Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_black",
			RESKIN_WORN_ICON_STATE = "kepi_sec_black"
		),
	)

/obj/item/clothing/head/hos_kepi
	name = "HoS kepi"
	desc = "Bonjour, commandante. A kepi for the Head of Security. It has a embroidered pattern going around it. This one appears well armored."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "kepi_sec_red_hos"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/hats_hos
	strip_delay = 60
	unique_reskin = list(
		"Red HoS Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_red_hos",
			RESKIN_WORN_ICON_STATE = "kepi_sec_red_hos"
		),
		"Blue HoS Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_blue_hos",
			RESKIN_WORN_ICON_STATE = "kepi_sec_blue_hos"
		),
	)

// END HATS ADDED BY APRIL

/obj/item/clothing/head/helmet/elder_atmosian
	desc = "The pinnacle of atmospherics equipment, an expensive modified atmospherics fire helmet plated in one of the most luxurous and durable metals known to man. Providing full atmos coverage without the heavy materials to slow the user down, it also offers far greater protection to most sources of damage, even offering great protection against gases, and other nasty things that try to get into your face."
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | STACKABLE_HELMET_EXEMPT | SNUG_FIT | HEADINTERNALS
	material_flags = NONE
	heat_protection = HEAD
	cold_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDEHAIR | HIDEMASK | HIDEEYES | HIDEEARS

/datum/armor/helmet_elder_atmosian
	melee = 40
	bullet = 30
	laser = 40
	energy = 40
	bomb = 100
	bio = 50
	fire = 100
	acid = 50
	wound = 25
