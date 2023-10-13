/obj/item/clothing/head/helmet/toggleable/pinwheel //sprites by Keila
	name = "pinwheel hat"
	desc = "Space Jesus gives his silliest hats to his most whimsical of goobers."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "pinwheel"
	inhand_icon_state = "pinwheel" //a reference to the hit movie Up
	toggle_message = "You spin your hat's spinner."
	alt_toggle_message = "You stop your hat's spinner."
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	///Cooldown for toggling the spinner.
	COOLDOWN_DECLARE(pinwheel_toggle_cooldown)

/obj/item/clothing/head/helmet/toggleable/pinwheel/try_toggle()
	if(!COOLDOWN_FINISHED(src, pinwheel_toggle_cooldown))
		return FALSE
	COOLDOWN_START(src, pinwheel_toggle_cooldown, 1 SECONDS)
	return TRUE
