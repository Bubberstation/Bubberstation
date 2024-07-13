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
