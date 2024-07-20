/obj/item/clothing/head/helmet/metrocophelmet
	name = "Civil Protection Helmet"
	flags_inv = HIDEHAIR | HIDEFACE | HIDESNOUT | HIDEFACIALHAIR
	desc = "Standard issue helmet for Civil Protection."
	icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	icon_state = "metrocopHelm"
	inhand_icon_state = null
	armor_type = /datum/armor/head_helmet

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
	return TRUE

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

//Bunny Ears from Monkee.

/obj/item/clothing/head/playbunnyears
	name = "bunny ears headband"
	desc = "A pair of bunny ears attached to a headband. One of the ears is already crooked."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	icon_state = "playbunny_ears"
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/playbunnyears
	greyscale_config_worn = /datum/greyscale_config/playbunnyears_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/playbunnyears/syndicate
	name = "blood-red bunny ears headband"
	desc = "An unusually suspicious pair of bunny ears attached to a headband. The headband looks reinforced with plasteel... but why?"
	icon_state = "syndibunny_ears"
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/head/playbunnyears/centcom
	name = "centcom bunny ears headband"
	desc = "A pair of very professional bunny ears attached to a headband. The ears themselves came from an endangered species of green rabbits."
	icon_state = "playbunny_ears_centcom"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/british
	name = "british bunny ears headband"
	desc = "A pair of classy bunny ears attached to a headband. Worn to honor the crown."
	icon_state = "playbunny_ears_brit"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/communist
	name = "really red bunny ears headband"
	desc = "A pair of red and gold bunny ears attached to a headband. Commonly used by any collectivizing bunny waiters."
	icon_state = "playbunny_ears_communist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/usa
	name = "usa bunny ears headband"
	desc = "A pair of star spangled bunny ears attached to a headband. The headband of a true patriot."
	icon_state = "playbunny_ears_usa"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/hats/caphat/bunnyears_captain
	name = "captain's bunny ears"
	desc = "A pair of dark blue bunny ears attached to a headband. Worn in lieu of the more traditional bicorn hat."
	icon_state = "captain"
	inhand_icon_state = "that"
	dog_fashion = null

/obj/item/clothing/head/playbunnyears/quartermaster
	name = "quartermaster's bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The brown headband denotes relative importance."
	icon_state = "qm"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cargo
	name = "cargo bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The gray headband denotes relative unimportance."
	icon_state = "cargo_tech"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/miner
	name = "shaft miner's bunny ears"
	desc = "Muddy gray bunny ears attached to a headband. Has zero resistance against the hostile lavaland atmosphere."
	icon_state = "explorer"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mailman
	name = "mailman's bunny ears"
	desc = "Blue and red bunny ears attached to a headband. Shows everyone your commitment to speed and efficiency."
	icon_state = "mail"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

