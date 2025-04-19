/obj/item/clothing/mask/gas/modulator
	name = "modified gas mask"
	desc = "An older model of gas mask issued for use on station to help protect against airborne hazards. This one appears to be \
		heavily modified, and the filter assembly has been replaced with a voice modulator to make the wearer sound more robotic."
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	max_filters = 0
	var/modulated_name = "Unknown" //Our SPEAKING name while our voice is cloaked. Defaults to "Unknown", but can be set by var editing.
	var/previous_special_name = null //Used to store a special name if they wearer has one before equipping the mask.
	var/modulate_voice = TRUE //If we are actually using the voice changer or not.


/obj/item/clothing/mask/gas/modulator/examine(mob/user)
	. = ..()
	. += span_notice("Its voice modulator is currently [modulate_voice ? "enabled" : "disabled"]. <b>Alt-click</b> to toggle it.")

/obj/item/clothing/mask/gas/modulator/click_alt(mob/user)
	modulate_voice = !modulate_voice
	to_chat(user, span_notice("You [modulate_voice ? "enabled" : "disabled"] [src]'s voice modulator."))
	update_voice(user)

	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/modulator/equipped(mob/user, slot)
	. = ..()
	if ((slot & ITEM_SLOT_MASK))
		RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(user, COMSIG_MOB_SAY)

	update_voice(user)

/obj/item/clothing/mask/gas/modulator/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)
	update_voice(user)

/obj/item/clothing/mask/gas/modulator/proc/update_voice(mob/user)
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	var/obj/item/organ/tongue/T = H.get_organ_slot(ORGAN_SLOT_TONGUE)

	if(H.special_voice != modulated_name)
		previous_special_name = H.special_voice

	if(H.wear_mask == src && modulate_voice)
		H.special_voice = modulated_name
		T.temp_say_mod = "states"
	else
		H.special_voice = previous_special_name
		T.temp_say_mod = initial(T.temp_say_mod)
		previous_special_name = null

	return

/obj/item/clothing/mask/gas/modulator/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if (!modulate_voice)
		return

	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
