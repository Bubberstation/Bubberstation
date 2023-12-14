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

/obj/item/clothing/head/helmet/toggleable/pinwheel/try_toggle()
	if(!COOLDOWN_FINISHED(src, pinwheel_toggle_cooldown))
		return FALSE
	COOLDOWN_START(src, pinwheel_toggle_cooldown, 1 SECONDS)
	return TRUE

/obj/item/clothing/head/helmet/toggleable/pinwheel/gold
	name = "magnificent pinwheel hat"
	desc = "The strongest possible pinwheel pinwheel hat. Such is fate that the silliest things in the world are also the most beautiful; others may not see the shine in you, but the magnificent pinwheel hat does. It appreciates you for who you are and what you've done. It feels alive, and makes you feel alive too. You see the totality of existence reflected in the golden shimmer of the pin." //Does literally nothing more than the regular pinwheel hat. Just for emphasis.
	icon_state = "pinwheel_gold"
// FNAF MASKS BELOW
// Credit:
// Virgo Sprites, from: https://github.com/VOREStation/VOREStation

/obj/item/clothing/head/costume/cardborg/fnaf
	name = "freddy fuckballs"
	desc = "is that the freddy fazbear????"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "freddyhead"
	inhand_icon_state = null
	lefthand_file = null
	righthand_file = null
	armor_type = /datum/armor/none
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/costume/cardborg/fnaf/bear
	name = "animatronic bear helmet"
	desc = "Har har. Very funny human, now, take off the costume."
	icon_state = "freddyhead"

/obj/item/clothing/head/costume/cardborg/fnaf/bird
	name = "animatronic bird helmet"
	desc = "This helmet kinda bad, though..."
	icon_state = "chicahead"

/obj/item/clothing/head/costume/cardborg/fnaf/bunny
	name = "animatronic bunny helmet"
	desc = "They do get a bit quirky at night."
	icon_state = "bonniehead"

/obj/item/clothing/head/costume/cardborg/fnaf/foxy
	name = "animatronic fox helmet"
	desc = "Just trying to help you, don't worry!"
	icon_state = "foxyhead"

